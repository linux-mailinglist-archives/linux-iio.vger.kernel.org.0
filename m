Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2353D56CB0C
	for <lists+linux-iio@lfdr.de>; Sat,  9 Jul 2022 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGISRQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Jul 2022 14:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGISRP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jul 2022 14:17:15 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBB17E1A
        for <linux-iio@vger.kernel.org>; Sat,  9 Jul 2022 11:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nX99/2hX8smpr+S+s5nvO/dNi1sRUAXxGeykdSF0PTI=; b=JqNWBpJz85P+lWbRhwQg58QTct
        LIackd/r0q4fMqm/1iDe6d55w6JV08heGRMb5YKgtQm3dJ2V9muR6y9JRklBSZa7m2sdxLJTMbMoD
        ysjo4Ju2zmR55BEgu6tNK4aFFRK4Vgv/+W3hE3x6WHDdYM2OO2/K6lZJacJVuHrhINJ5TFdv0kDPV
        3y7GSJlzk1FMPoHHDCyZBtmv7C+dqG/ttSbncrFDOCJ9cp5axz/iZrtf4suOEDGPisZKPqX9VtPes
        o+MiqmRnyv7J+U2wlofx9bLjgS4tbxfwfVjVliRBBCd8T9h6dXQVxjSccypfaHIbSHo2h8qDSVo+F
        qIFMoXnw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oAF0v-0006sM-Mg; Sat, 09 Jul 2022 20:17:09 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oAF0v-000R6a-FA; Sat, 09 Jul 2022 20:17:09 +0200
Message-ID: <1f8d218c-af94-722e-6ea6-f2b902a0b0ba@metafoo.de>
Date:   Sat, 9 Jul 2022 20:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: ti-ads7950: selecting the adc input range
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Thorsten Scherer <t.scherer@eckelmann.de>,
        kernel@pengutronix.de
References: <20220708080257.y6wn7pztylujepyr@pengutronix.de>
 <441bfa83-4014-fed9-3527-7db34df7da3a@metafoo.de>
 <20220709171013.eol6fpv5imtijgsn@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220709171013.eol6fpv5imtijgsn@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26596/Thu Jul  7 09:53:54 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/9/22 19:10, Uwe Kleine-König wrote:
>
>> What we've done in the past in the IIO framework is to make the scale
>> property writable for such devices. Together with a scale_available property
>> to list valid options. This is the most flexible option as it allows to
>> change the setting at runtime for applications where it is required.
> Which driver would you recommend me to study for that approach?

The closest to what you want is probably ti-ads1015. You need to

  * implement the read_avail callback to get the possible values
  * set info_mask_shared_by_all_available to BIT(IIO_CHAN_INFO_SCALE)
    for the channels
  * implement the write_raw callback and handle IIO_CHAN_INFO_SCALE to
    update the setting
  * handle IIO_CHAN_INFO_SCALE in the read_raw callback to report the
    current scale

