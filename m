Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8387263E3C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 09:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIJHNB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 03:13:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgIJG7L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 02:59:11 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D585821D40;
        Thu, 10 Sep 2020 06:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599721151;
        bh=xOzDDEuhcg0+WXu//QXZGuTvH72fhH7NrPswesxiZA8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gXL+ijTBw11FfLjLqyYUZfKHTa4Zvs2N1LU7JLoiGcBQ7DNHaV/PzX6MCoDp00EAp
         wlCG83HzbzCGx6nVtzWC2pIby9quHCEjEIqQec3QmfPoutTorFkcOj+v+bXRg2MhHa
         jwCRShpKk3NeYVaSR0bdXRVGBByi3LEGRCE3M3wI=
Received: by mail-ej1-f54.google.com with SMTP id r7so7071637ejs.11;
        Wed, 09 Sep 2020 23:59:10 -0700 (PDT)
X-Gm-Message-State: AOAM530WBIRzWslzlsBcuGP2kDBY0deZMa9dTEbWrs4Th51duXFWR8HV
        UG88jKwJDE3Dr0BsAM36V7dWEf6+3rDs6rqwgNE=
X-Google-Smtp-Source: ABdhPJyaVrBohjZL8QO712q55aVYmvP/Im4PscZba1DFwlJPfAPVYEdWgkk0QsgOlmQCRth1GWIRcKjY7V63cmwrs/Y=
X-Received: by 2002:a17:907:724f:: with SMTP id ds15mr7191226ejc.119.1599721149291;
 Wed, 09 Sep 2020 23:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200829064726.26268-1-krzk@kernel.org> <20200829064726.26268-8-krzk@kernel.org>
 <20200909193600.41970d8c@archlinux> <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
 <a37c69f2-1f16-2680-2716-0c1b77748d55@axentia.se> <CAHp75Vc4-zkkWtOz8w7pA0Vu1yMAVodhPSLQ1NJH4K+j9XD52g@mail.gmail.com>
In-Reply-To: <CAHp75Vc4-zkkWtOz8w7pA0Vu1yMAVodhPSLQ1NJH4K+j9XD52g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 10 Sep 2020 08:58:57 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
Message-ID: <CAJKOXPdNAw8scFKCGaC_hp4jMyLD_mFLKr=+fGKSm6nCkcRF9g@mail.gmail.com>
Subject: Re: [PATCH v3 08/18] iio: adc: stm32: Simplify with dev_err_probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 at 08:52, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>
>
> On Thursday, September 10, 2020, Peter Rosin <peda@axentia.se> wrote:
>>
>> Hi!
>>
>> On 2020-09-09 21:57, Krzysztof Kozlowski wrote:
>> > On Wed, 9 Sep 2020 at 20:36, Jonathan Cameron <jic23@kernel.org> wrote:
>> >>
>> >> On Sat, 29 Aug 2020 08:47:16 +0200
>> >> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> >>
>> >>> Common pattern of handling deferred probe can be simplified with
>> >>> dev_err_probe().  Less code and also it prints the error value.
>> >>>
>> >>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> >>>
>> >> I don't have the thread to hand, but this tripped a warning next
>> >> and the patch was dropped as a result. See below.
>> >
>> > Thanks for letting me know. If you mean the warning caused by:
>> > https://lore.kernel.org/lkml/20200909073716.GA560912@kroah.com/
>> > then the driver-core patch was dropped, not the iio one:
>> > https://lore.kernel.org/linux-next/20200909074130.GB561485@kroah.com/T/#t
>> >
>> > So we are good here :)
>>
>> No, we are definitely not good. See below. That means "See below", and
>> not "Please take a guess at what is being talking about".
>
>
>
>>
>> >>> @@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>> >>>               priv->booster = devm_regulator_get_optional(dev, "booster");
>> >>>               if (IS_ERR(priv->booster)) {
>> >>>                       ret = PTR_ERR(priv->booster);
>> >>> -                     if (ret != -ENODEV) {
>> >>> -                             if (ret != -EPROBE_DEFER)
>> >>> -                                     dev_err(dev, "can't get booster %d\n",
>> >>> -                                             ret);
>> >>> -                             return ret;
>> >>> -                     }
>> >>> +                     if (ret != -ENODEV)
>> >>> +                             dev_err_probe(dev, ret, "can't get booster\n");
>> >>
>> >> This tripped a warning and got the patch dropped because we no longer
>> >> return on error.
>>
>> As Jonathan already said, we no longer return in this hunk. I.e., you have
>> clobbered the error path.
>
>
> Exactly my point why I proposed _must_check in the first place.

That was not exactly that point as you did not mention possible errors
but only "miss the opportunity to optimize". Optimization is different
things than a mistake.

Best regards,
Krzysztof
