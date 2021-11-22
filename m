Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5266458D83
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 12:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhKVLiS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Nov 2021 06:38:18 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57697 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238137AbhKVLiR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2021 06:38:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D06FC3201C39;
        Mon, 22 Nov 2021 06:35:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Nov 2021 06:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=v
        TleVrIcuSL31T2y2V9IamY8CU7ElbphPCwqQMlCxGg=; b=iiN2SzjRXh8eyhgSv
        qE2zogdfN6zcME5dNJD8z+8NDG3S8obWRR0wZiqd8Sx4CDPz0lYxt7fOPF1AvMlM
        Qm2HrI4I+Tl+n9f3Pnl9cjYvB8WXJRhg8ZnE+xAGrkLIOTwHgkBE5YBD/Hfg+roR
        TSGakXf18I5fHBOs8uhJnk84R2m2oheBCvapfv9WgjO5gK/GRtDWlZhot7BYSn+K
        DrWn2L9crC873vB/h5a/UrFPddNQBxwe1fwRYYnGx2fA1N0DotWmK5hrQYhPOUZh
        6VioEYHWObGqabJWsdIjJC4e+2t1s9Ngrsm/j8t2oA4mps/Zgfxv+owaK7XVH45Q
        /NERQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=vTleVrIcuSL31T2y2V9IamY8CU7ElbphPCwqQMlCx
        Gg=; b=C671RfbnX3vGp+Hb+d636Oq8ELeCIeDOCrlZWdZWBOq/xawfLI4IS09wX
        Wz+d4oWb2BtZnIlwHrHqCTKBkSiCjmmNUcA3748dKb78iWlFBW6IoJzQaeuVMq15
        a07YD78G1vguRQ3e54XeDIvNwAmeatridemlpwKKXxFnitGUurQqHCKL4ATgbY3m
        8fcqPf+omYpWZBPENard7J4NhDYgZTL4ASG1JzfY6W7/g2FXmp3AH0+4m1FBLEy0
        UMW7b+Yq1lxvwO7/+5ZOfj/mCryftkhagFc9cTnKiQiWrp7kxwZklIBc/3c+XC5+
        4TJfNYi7tLMsNbDjpthoTYl31VoOw==
X-ME-Sender: <xms:bYCbYRURhtqM9C24vd7v9wKlK8IOj1djstYcmsN4jlH4jK2kLLW-7w>
    <xme:bYCbYRlAwLvFr5XD2sJLD8wax27QYfJdLFmSWKFolrAf6ER28MT9oKPuMQQhxVwTn
    wrf1obT-i_3D7WRbw>
X-ME-Received: <xmr:bYCbYdYY3mZ4sVB7tg4gewUpgW0ouGSEXgJjZmIofCE-OGL3Gybbt5xr5_WqldbzBTJdf11-dX_gs3eWWsgme9CBQJb1CyjOnHFlvUAZQTDDf9t8t_VWTcMO-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeeggdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefvfhfhuffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtjeeiuddugfffveetkeffgeffgedutdfgfeekudevudekffeh
    tdefveeuvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:bYCbYUVDDBW0oNmQ3KhC2dnjpjsTcU4a4dvBhl_Fl_VMzWXZOqUzIw>
    <xmx:bYCbYblmiBCaHSLTUvvH14I2v6F66maRPrKZIekXzI7blN7pKFM-Qw>
    <xmx:bYCbYReP0DcogwPqCC1u9IwQcU5-NCSMb_HpyhzgLO8IYjnWFWwoiw>
    <xmx:boCbYd7iPJNttDMP4F5mu2knBGWz6Rd2FKRHTKPre2uVfDMwmuYeKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 06:35:09 -0500 (EST)
To:     Evgeny Boger <boger@wirenboard.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Quentin Schulz <foss@0leil.net>, linux-sunxi@lists.linux.dev
References: <20211118141233.247907-1-boger@wirenboard.com>
 <20211118141233.247907-3-boger@wirenboard.com>
 <20211122104915.zism6uadgwxjz5d2@gilmour>
 <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: document TS voltage in AXP
 PMICs
Message-ID: <35630e89-4988-a6a9-b801-0e9e44419684@sholland.org>
Date:   Mon, 22 Nov 2021 05:35:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d1a18116-e198-1b26-d73a-36fbf31aaa81@wirenboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/22/21 5:17 AM, Evgeny Boger wrote:
> 22.11.2021 13:49, Maxime Ripard пишет:
>> On Thu, Nov 18, 2021 at 05:12:33PM +0300, Evgeny Boger wrote:
>>> Most AXPxxx-based reference designs place a 10k NTC thermistor on a
>>> TS pin. axp20x IIO driver now report the voltage of this pin via
>>> additional IIO channel. Add new "ts_v" channel to the channel
>>> description.
>>>
>>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
>> Would it make sense to put the resistance in the DT as well or is it
>> made mandatory by Allwinner?
>>
>> Maxime
> Well, I don't think so. Basically, by default AXP20x injects 80uA 
> current into the TS pin and measure the voltage. Then, there are 
> voltage thresholds to stop charging if the battery is too hot or too 
> cold. The default thresholds were calculated by the manufacturer for 
> default 10k resistance and 80uA current. Finally, if TS pin is
> shorted to GND, the AXP2xx will detect it and won't shut down 
> charging. Note that AXP2xx doesn't convert the measured voltage to 
> temperature.

Agreed, since the ADC driver only works with voltages, the resistance is
not relevant to it, so a resistance property does not belong here.

> So while it's possible to use AXP2xx with resistance other than 10k, 
> it will require us to override these protection thresholds.
> Moreover, if one want to put the actual resistance in DT, then the
> driver would need to calculate these protection thresholds based on
> NTC parameters and injection current.
That means we do need a resistance property for the battery charger
driver, because it does need to calculate temperature.

Regardless of the reference design, the resistance is variable in
practice. At least some early v1.0 PinePhones shipped with batteries
containing a 3 kOhm NTC. And the battery is removable, with an
off-the-shelf form factor, so users could install aftermarket batteries
with any NTC resistance.

Right now, people with these batteries are disabling the TS; otherwise
the PMIC refuses to charge them. It would be good to re-enable the TS by
coming up with the proper voltages for the min/max thresholds. And there
are power supply properties we can use to expose the current temperature
and those thresholds to userspace (at least as read-only).

Regards,
Samuel
