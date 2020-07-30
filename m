Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371BB233027
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 12:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgG3KSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jul 2020 06:18:54 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:44500 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3KSx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 30 Jul 2020 06:18:53 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BHRG12gMjzMsSF;
        Thu, 30 Jul 2020 12:18:49 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BHRFm4zvGz2xFY;
        Thu, 30 Jul 2020 12:18:36 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.117) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 30 Jul
 2020 12:18:15 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: New driver
Date:   Thu, 30 Jul 2020 12:18:14 +0200
Message-ID: <2956063.qbQfZA7an0@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CAHp75Vcz1kv_xhaRZMdK21KrkAbeBLE3evJNsjA2yMa=V0Yb0g@mail.gmail.com>
References: <20200728062831.1143-1-ceggers@arri.de> <20200728062831.1143-3-ceggers@arri.de> <CAHp75Vcz1kv_xhaRZMdK21KrkAbeBLE3evJNsjA2yMa=V0Yb0g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.117]
X-RMX-ID: 20200730-121836-4BHRFm4zvGz2xFY-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

thanks for the extensive review. Almost all of you comments will be integrated 
into v3. 

On Tuesday, 28 July 2020, 20:00:31 CEST, Andy Shevchenko wrote:
> On Tue, Jul 28, 2020 at 9:32 AM Christian Eggers <ceggers@arri.de> wrote:

> > +       if (data->client->irq)
> > +               init_completion(&data->completion);
> I believe it should be reinit_completion().
added missing init_completion() in probe().

> > +       /* During measurement, there should be no traffic on the i2c bus 
*/
> > +       i2c_lock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> Hmm.. Really?
yes. According to the datasheet, the device is very sensitive to external 
noise
during measurement.

> > +               *val = (1 << (data->creg3 & 0b11)) * 1024 * 1000;
> 
> BIT()? GENMASK() ? 1000 I believe defined already.
Please recheck in v3. What shall I use instead of "1000"?

> > +                       /* saturate all channels (useful for overflows) */
> > +                       iio_buffer[1] = 0xffff;
> > +                       iio_buffer[2] = 0xffff;
> > +                       iio_buffer[3] = 0xffff;
> 
> Magic!
Replaced by U16_MAX. Do you want to see something else here? It is required
to communicate measurement errors to user space as the application will have
to adjust integration time and gain.

> > +static ssize_t as73211_show_samp_freq_available(
> > +               struct device *dev __always_unused,
> > +               struct device_attribute *attr __always_unused,
> > +               char *buf)
> > +{
> > +       size_t len = 0;
> > +       int i;
> > +
> > +       for (i = 0; i < 4; i++) {
> > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> > +                       (1 << (i + 10)) * 1000);
> > +       }
> > +
> > +       /* replace trailing space by newline */
> > +       buf[len - 1] = '\n';
> > +
> > +       return len;
> > +}
> 
> Repetition of IIO core functionality?
> 
> Ditto question for the other similar functions.
Can you please give me a pointer to an example? The list of available values 
of
some attributes depend on the current value of other attributes.

regards
Christian



