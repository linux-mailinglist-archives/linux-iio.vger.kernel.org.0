Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F01135D
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2019 08:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbfEBGa5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 02:30:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41139 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfEBGa5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 02:30:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so1075764edd.8
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2019 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XifxbheY5ZJMcIjK1Dcna4ZV4VxhYdswgXuoHoN07ds=;
        b=W5Vi6C4PALXYi9bntNvSqVcq+/UxvMKNNQKeCYfXtVU7JKlp4CJa8ZE9p/ZyV0L1EI
         u36NkKV0n2EyaAIsRxMZcAoIbmDNa22UuFVxhwHzZvGHNAkiBWTvXGfO1xMaStYTbiiO
         1ygs9UiNA6h4aVrx7Qz2LABuy4WsmKnthewxz4Hbu7Ln9WOwfj0nhIYtJHlKunxBStgo
         3PCf1wBDOfPzFxSjwdbac/75+Ve2gkcIvIGIOQkw7aUzbRIHEVtBprgompOg4L6J7wrO
         jUsKrjkv+bVEQn6y+spUiwI5iLntSNZGNYmDicVjIg3Fe6fpxpunUk2JyV8ybu67oTac
         3KNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XifxbheY5ZJMcIjK1Dcna4ZV4VxhYdswgXuoHoN07ds=;
        b=TiRHZcR+OH/JPlSp45GQGI1BZ/ZOm5h9M6aPF7bxi7t4jC9cLUTGZ1ZSQOZXspbbnL
         h794WClvT4Du1QXuIkrw50dv4yKmOUg9jDH3HzdeFss92cTDcBFa3dNzlIidVFwLAQ4w
         rhuWFoIqxI+EertDyHF69OahpABE9j55Ro0HZiJAQF7EFIS+nUB+JrONsMYxYGcyj6cZ
         LLEThuIRQ/ScZZI2I9hFtIorEisYp+1e+VI2vh/e54n3y73yTotHMcVnzWvj+2Wpv7hb
         RCo/xbwdTk+EXt+skxxqOg8uZYa0M+hlb3sCqARbD6gY6DqOBGn6A+gycs/AIqlYEcK+
         WBNw==
X-Gm-Message-State: APjAAAXH4pEnFhkZ2MsHEJno/f7sweR3l4Xs+24a3tUYF5Qtu0HYjOv7
        JLrPL/YQTx8GBsDOaBGxgFJtD23lJTM=
X-Google-Smtp-Source: APXvYqzCXqzBmV7CbIi+qzTwlBRjN6AtrUKhicdLtIjZhkphBOm2hAcbWT7moAEIfqLspoDjt+YedQ==
X-Received: by 2002:a50:8c03:: with SMTP id p3mr1271439edp.267.1556778655182;
        Wed, 01 May 2019 23:30:55 -0700 (PDT)
Received: from ?IPv6:2a02:a03f:4485:9200:4176:609:b67e:249a? ([2a02:a03f:4485:9200:4176:609:b67e:249a])
        by smtp.gmail.com with ESMTPSA id b23sm4066266ede.75.2019.05.01.23.30.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 23:30:54 -0700 (PDT)
Subject: Re: [PATCH 1/6] iio: ad7949: Support internal Vref
To:     Adam Michaelis <adam.michaelis@rockwellcollins.com>,
        linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com
References: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <4f674e6a-2346-4ca3-4043-205e54473dbd@essensium.com>
Date:   Thu, 2 May 2019 08:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556745423-11368-1-git-send-email-adam.michaelis@rockwellcollins.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
I read your patch series and it seems really good. Thank you for the 
improvements. :)
But I have one comment about it there:

Le 01/05/2019 à 23:16, Adam Michaelis a écrit :
> @@ -223,10 +247,18 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
>   {
>   	int ret;
>   	int val;
> +	u16 adc_config = 0;
>   
> -	/* Sequencer disabled, CFG readback disabled, IN0 as default channel */
>   	ad7949_adc->current_channel = 0;
> -	ret = ad7949_spi_write_cfg(ad7949_adc, 0x3C79, AD7949_MASK_TOTAL);
> +	ad7949_adc->cfg = 0;
> +
> +	adc_config = (0x3c << 8);
> +	adc_config |= ((ad7949_adc->current_channel & 0x07) << 7);
> +	adc_config |= (1 << 6);
> +	adc_config |= (ad7949_adc->ref_sel << 3);
> +	adc_config |= 1;
> +
> +	ret = ad7949_spi_write_cfg(ad7949_adc, adc_config, AD7949_MASK_TOTAL);

That should be great to replace some _magic constants_ by a more 
explicit name, shouldn't it? Especially (0x3c << 8) and (1 << 6 parts).

Regards,

Charles-Antoine Couret

