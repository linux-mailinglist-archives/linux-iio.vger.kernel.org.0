Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90F16A4A5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2020 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXLNz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Feb 2020 06:13:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42247 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgBXLNz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Feb 2020 06:13:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so6261579wre.9
        for <linux-iio@vger.kernel.org>; Mon, 24 Feb 2020 03:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mh1d0aGZXBcGpL9RuplRZdSm3AVkRnYe3oS1toATjYE=;
        b=tL8VJS4ob05hCQrgIx8wpD7rln8HVS80aBRN3zNf1hHjE5+2uwPcKZQD4kpRNRUzVw
         y2HNshaAjNmGi7Sov6ebNaGRnmUuoFACFUBstueEhotMxvTvqQP6CzX4Zyo8FSbAuDv7
         QFlK9ZOzujld6GYBDPa5xRg/5EYIRSZAA3fBy+2iVGLWMDfS3nb+faUGolfyc32UvgH7
         fOzaRlXd8bsTSYUCHK0fvC4P4jRXkI/34JtDLW7OdDztGP0OEEChAL70D0tjb+ufFEUK
         rLsnnXpGZsCfYYm/lo66E9zepWp7JS8qnQUEY+oX7MA8c390zjk+EDH5IkBdp0bACXEq
         fbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mh1d0aGZXBcGpL9RuplRZdSm3AVkRnYe3oS1toATjYE=;
        b=GYhFS+oMdT8uhb/MSu1VZL4mU+MeWb004NnMI5sn5I8lETuaaLY8HFCZG2G0i7Aq/1
         VJxBW8c4zpMRlyQziGDmL73nOyzVvVbH+0VgOopPMf09Dl1SCnnuOYuQcF+B8YMRSj8O
         yiTVdiNuSJXlgWxYEjPuRxqXf33CSVvpNVjxEd5ZoNOsMYD6ePKSm1y0nA/3vVd5mo2E
         rCnFl90bPRhKksrMx+dlJ+popAfyDnopqODUBiITHUAyszLd7URHx7u3OyUjy2ylpldl
         SDrdvqJ3qDNVkQAkK5TBroJe6DHOFIRVuEaLzH+ZbrQHJX+wiB/nAK8PhVx0wwUkoB7A
         so4g==
X-Gm-Message-State: APjAAAUREKGKgFW19zxGb/6xbohZQbwjYFsTayZnnb/oX69oIjVhG97/
        pJHUg0xyuWndRoz9Z+SYvcdsUg==
X-Google-Smtp-Source: APXvYqzSwHgv7l1zqhx5avrCHp4FE1Qp8CaMgplZWJajrSVOxXJtGoOGvCDqGgzPuchDv1c+GXos3w==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr65289586wrv.259.1582542832122;
        Mon, 24 Feb 2020 03:13:52 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id d17sm12802127wmb.36.2020.02.24.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 03:13:51 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:14:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v5 1/7] dt-bindings: Add bindings for Azoteq
 IQS620A/621/622/624/625
Message-ID: <20200224111422.GR3494@dell>
References: <1581895931-6056-1-git-send-email-jeff@labundy.com>
 <1581895931-6056-2-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581895931-6056-2-git-send-email-jeff@labundy.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 Feb 2020, Jeff LaBundy wrote:

> This patch adds device tree bindings for the Azoteq IQS620A, IQS621,
> IQS622, IQS624 and IQS625 multi-function sensors.
> 
> A total of three bindings are presented (one MFD and two child nodes);
> they are submitted as a single patch because the child node bindings
> have no meaning in the absence of the MFD binding.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v5:
>   - Corrected spelling of "data sheets" to "datasheets"
>   - Replaced words "additional air button" with "proximity-activated function"
>     in comment above first example
> 
> Changes in v4:
>   - None
> 
> Changes in v3:
>   - Specified 'additionalProperties: false' within the parent MFD node and all
>     child nodes ("keys", "hall-switch-north/south" and "pwm")
>   - Defined the "hall-switch-north/south" child nodes unconditionally and then
>     inverted the subsequent if/then to filter them from devices for which that
>     functionality is unavailable
>   - Added Reviewed-by trailer
> 
> Changes in v2:
>   - Removed "prox" child node and moved "keys" and "pwm" child nodes to their
>     own bindings
>   - Replaced linux,fw-file property with more common firmware-name property
>   - Converted all bindings to YAML
> 
>  .../devicetree/bindings/input/iqs62x-keys.yaml     | 132 +++++++++++++++
>  Documentation/devicetree/bindings/mfd/iqs62x.yaml  | 179 +++++++++++++++++++++
>  .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |  32 ++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
