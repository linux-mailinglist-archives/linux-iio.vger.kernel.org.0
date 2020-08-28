Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC225547A
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgH1GYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 02:24:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38138 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1GYt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2020 02:24:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id b2so143178edw.5;
        Thu, 27 Aug 2020 23:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5CxlDCkzVcslzoI2Y1jCiSF6kba4WwnH5Gi/cefvyw=;
        b=A7xZo3sEwDq1/H+BBUomIsJU6WyFanOBQUHo3TMTDGltE2kvlvsXNSPA0QOdqvP83/
         MimFnYqP80AjRw6Q4twPkuVoW56FbenTNB5lSCcPHpFPtltCDFlHKLSM0rqWP3/f5EzH
         NSzuugftvm04cHpd+oA84iibgy+kSXWdMCkkBge+gx7o1+EUWd3VBtuVkAF81D2dLYYT
         fhiKHZ7EHl00p8PZCBvLpsXv9Ueq/ZpWgp9IX9VDv04o9bXMnnDqwpKgTp+qidI9kTMM
         Jqbc3SxUL+OoE48h382crlhxo73Crpilsn+d9assNp1uvJZaLtMLs1/8MHcWNxshXGAp
         A+EQ==
X-Gm-Message-State: AOAM532eBVHFBCmXnm2a5k2doo2qW9pkBNHtHoAczzUJRoy3CqLZJQSq
        OkbPcEKXENioM2BgkbnMz7g=
X-Google-Smtp-Source: ABdhPJxeW0KD9hKV2DDa/EdMjU+5aNFXnsb+vG7w/NJJBOIDbbnxf68rltSFEJDK0Zq+nf99uGbtHw==
X-Received: by 2002:a05:6402:2039:: with SMTP id ay25mr310806edb.87.1598595886637;
        Thu, 27 Aug 2020 23:24:46 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id w20sm3809310ejc.77.2020.08.27.23.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:24:46 -0700 (PDT)
Date:   Fri, 28 Aug 2020 08:24:43 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with
 dev_err_probe()
Message-ID: <20200828062443.GA17343@pi3>
References: <20200827192642.1725-1-krzk@kernel.org>
 <20200827192642.1725-9-krzk@kernel.org>
 <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 11:46:40PM +0200, Peter Rosin wrote:
> On 2020-08-27 21:26, Krzysztof Kozlowski wrote:
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and also it prints the error value.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Wrap dev_err_probe() lines at 100 character
> > ---
> >  drivers/iio/afe/iio-rescale.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> > index 69c0f277ada0..8cd9645c50e8 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -276,11 +276,8 @@ static int rescale_probe(struct platform_device *pdev)
> >  	int ret;
> >  
> >  	source = devm_iio_channel_get(dev, NULL);
> > -	if (IS_ERR(source)) {
> > -		if (PTR_ERR(source) != -EPROBE_DEFER)
> > -			dev_err(dev, "failed to get source channel\n");
> > -		return PTR_ERR(source);
> > -	}
> > +	if (IS_ERR(source))
> > +		return dev_err_probe(dev, PTR_ERR(source), "failed to get source channel\n");
> 
> Hi!
> 
> Sorry to be a pain...but...
> 
> I'm not a huge fan of adding *one* odd line breaking the 80 column
> recommendation to any file. I like to be able to fit multiple
> windows side by side in a meaningful way. Also, I don't like having
> a shitload of emptiness on my screen, which is what happens when some
> lines are longer and you want to see it all. I strongly believe that
> the 80 column rule/recommendation is still as valid as it ever was.
> It's just hard to read longish lines; there's a reason newspapers
> columns are quite narrow...
> 
> Same comment for the envelope-detector (3/18).
> 
> You will probably never look at these files again, but *I* might have
> to revisit them for one reason or another, and these long lines will
> annoy me when that happens.

Initially I posted it with 80-characters wrap. Then I received a comment
- better to stick to the new 100, as checkpatch accepts it.

Now you write, better to go back to 80.

Maybe then someone else will write to me, better to go to 100.

And another person will reply, no, coding style still mentions 80, so
keep it at 80.

Sure guys, please first decide which one you prefer, then I will wrap it
accordingly. :)

Otherwise I will just jump from one to another depending on one person's
personal preference.

If there is no consensus among discussing people, I find this 100 line
more readable, already got review, checkpatch accepts it so if subsystem
maintainer likes it, I prefer to leave it like this.

> You did wrap the lines for dpot-dac (12/18) - which is excellent - but
> that makes me curious as to what the difference is?

Didn't fit into limit of 100.

Best regards,
Krzysztof


