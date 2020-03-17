Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581D41884F7
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCQNLs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 09:11:48 -0400
Received: from www381.your-server.de ([78.46.137.84]:47428 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgCQNLs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 09:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DPBt6a2ecj+oPPIEOONyeXXPrj98nh9q+dqBm7gAtso=; b=mMby00Z43dqeyhZbuPee4ExS6N
        4gkp9xdwpVvaPIV2W3AJXxcgJIBTjOnq0QVUOJN/gK8L21MwJDUbfnukN8Lxa1Km19sMoa3CAq05j
        +nFca35tlZP+5P6eMNDc2DBLfGBhdodQ7Z5tLGsJush9KUIH20nMppWDpY0WAyqZjlZPAKA7N5cWm
        RJ9q5CHaGJglL9+nRqHzVZedaF2bEA7JL2U6SghM6U6HjTLIRcDFj15pnuD+pTDxHEyKdufObDZ8l
        CQZ+3BhAt+aNNZeZUOLQg75SB0u8Ql42loQPAnlApssu+nF9CUk6fGvZkQeLTO71AZq3cdVcZZtnq
        5kE92uDA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEC0P-0001j3-TD; Tue, 17 Mar 2020 14:11:38 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEC0P-000Dpk-Ij; Tue, 17 Mar 2020 14:11:37 +0100
Subject: Re: [PATCH v2 3/4] iio: vcnl4000: Export near level property for
 proximity sensor
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
Cc:     Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <cover.1584380360.git.agx@sigxcpu.org>
 <5566fe01df933d3281f058666e2147cb97b38126.1584380360.git.agx@sigxcpu.org>
 <c787921f-c412-4986-14ea-e31b531d3d5b@metafoo.de>
 <20200317120535.GA16807@bogon.m.sigxcpu.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <ab8f970b-f95f-b34b-7e4d-c2cc64d94886@metafoo.de>
Date:   Tue, 17 Mar 2020 14:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317120535.GA16807@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 1:05 PM, Guido Günther wrote:
> Hi,
> On Mon, Mar 16, 2020 at 07:23:01PM +0100, Lars-Peter Clausen wrote:
>> On 3/16/20 6:46 PM, Guido Günther wrote:
>>> [...]
>>> +static ssize_t vcnl4000_read_near_level(struct iio_dev *indio_dev,
>>> +					uintptr_t priv,
>>> +					const struct iio_chan_spec *chan,
>>> +					char *buf)
>>> +{
>>> +	struct vcnl4000_data *data = iio_priv(indio_dev);
>>> +
>>> +	return sprintf(buf, "%u\n", data->near_level);
>>> +}
>>> +
>>> +static const struct iio_chan_spec_ext_info vcnl4000_ext_info[] = {
>>> +	{
>>> +		.name = "near_level",
>> Generally having properties with a underscore in them breaks generic parsing
>> of the property name by userspace applications. This is because we use
>> underscores to separate different components (type, modifier, etc.) of the
>> attribute from each other.
>>
>> Do you think calling this "nearlevel" would work?
> That works as well. I'll change that for v3.
>
> For my education: Is the type, modifier policy written down somewhere
> (similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/leds/leds-class.rst#n44
> )?

Good point, this is quite badly documented at the moment.

The only thing I could find is this presentation by Daniel 
https://events.static.linuxfound.org/sites/events/files/slides/lceu15_baluta.pdf#page=9

- Lars

