Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA76235903
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgHBQjM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 12:39:12 -0400
Received: from mailout07.rmx.de ([94.199.90.95]:58461 "EHLO mailout07.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgHBQjM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Aug 2020 12:39:12 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout07.rmx.de (Postfix) with ESMTPS id 4BKRYS3r3jzBvn3;
        Sun,  2 Aug 2020 18:39:08 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BKRY36QJrz2TS6Z;
        Sun,  2 Aug 2020 18:38:47 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.16) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sun, 2 Aug
 2020 18:38:24 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH v5 0/2] iio: light: Support AMS AS73211 digital XYZ sensor
Date:   Sun, 2 Aug 2020 18:37:33 +0200
Message-ID: <20200802163735.76617-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.16]
X-RMX-ID: 20200802-183849-4BKRY36QJrz2TS6Z-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the AMS AS73211 digital XYZ sensor. Some
comments to the review emails below...

Again, many thanks for the comprehensive reviews.

Changes in v5:
---------------
- [1/2] Reviewed by Rob Herring
- [2/2] Added KHZ_PER_HR define
- [2/2] Added AS73211_SAMPLE_FREQ_BASE define
- [2/2] Slight changes in comments
- [2/2] Claim direct mode in write_raw()
- [2/2] Saturate only in case of overflow
- [2/2] Don't set indio_dev->dev.parent
- [2/2] Fix error path (order) in probe()

Changes in v4:
---------------
- Integrated 2nd review from Andy Shevchenko
- Use more devm_ functions in as73211_probe()

Changes in v3:
---------------
- Integrated comments from Andy Shevchenko
- Integrated comments from Jonathan Cameron

Changes in v2:
---------------
- Fix $id in dt binding
- Document full I2C address range in "reg" property
- Move "buffer" member out of "struct as73211_data"
- Fix sparse warnings by using correct data types


On Friday, 31 July 2020, 17:41:47 CEST, Andy Shevchenko wrote:
> On Fri, Jul 31, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:
> > devm_iio_device_alloc() doesn't pass 'dev' to iio_device_alloc().
> > I already looked around, but I didn't find. And after debugging
> > v5.4, devm_iio_device_alloc() definitely doesn't do it.
> 
> Why are you talking about v5.4? We are in v5.8 cycle contributing to v5.9.
v5.4-rt is the version for my product release. Current base for these
patches is 5.8-rc6


On Friday, 31 July 2020, 18:19:55 CEST, Jonathan Cameron wrote:
> > On Fri, Jul 31, 2020 at 1:52 PM Christian Eggers <ceggers@arri.de> wrote:
> > Recently IIO gained some features among which I think the one that
> > assigns parent devices.
> 
> yup. This should be in linux-next now for the coming merge window (which
> probably opens on Sunday).
Thanks for the hint. Is there a particular tree which is preferred for
IIO development?


On Saturday, 1 August 2020, 17:29:58 CEST, Jonathan Cameron wrote:
> On Fri, 31 Jul 2020 09:01:14 +0200 Christian Eggers <ceggers@arri.de> wrote:
> > +static int as73211_write_raw(struct iio_dev *indio_dev, struct
> > iio_chan_spec const *chan, +			      int val, int val2, long mask)
> > +{
> > +	...
> > +	/* Need to switch to config mode ... */
> 
> Is this safe whilst we are doing a capture?
> You may want to claim_direct_mode for write_raw to ensure we don't get such
> a race.
> 
That's an important point! As I use iio-trig-sysfs, I never had any
problems with this. But if for instance iio-trig-hrtimer is active, this
could become a problem.

In v5, I have claimed direct mode. For the application this means, that
buffer/enable has to be set to '0' before any settings can be
changed. As libiio doesn't support enabling/disabling a buffer directly,
the buffer needs to be destroyed and newly constructed.



