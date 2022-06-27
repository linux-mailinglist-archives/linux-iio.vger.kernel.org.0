Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E771855DA02
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiF0Ly2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 07:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiF0LxS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 07:53:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E6DF60
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 04:47:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m184so5242124wme.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 04:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=INtcSWuYJqZv/51emZbtl4GZQaiJjf0FK2Rx9NjjvdU=;
        b=lXdwJ3T0hWwRd2FjZSZn9NLejvaZP+hX41vR+vG5z+fZjvrrydxxOLj1Mni1SG4T7y
         Qe5BcuNLmNeZK/FS3GCOOf7x+pDpbcUgJxr+V6XrdkoUNaSn914ItjglppuYDkfPvMiy
         zytYCkt0WQaCqTxpSMo592v4DxD5Hx+tQoZjbuwc/DFTsnQlp1GFxT7EOXhVdjxvQlTQ
         Fo4M12AvXbbyS7Ws7mXh98rG/Ya9pqX80Gr4tTZKEL8OAe3xNpLc9mOK3hf9A+XHLuuA
         AkjiwLE1Z67hLAP8huWWKsZh7jBohB5FQNIhzUz32SHG+Q1ftRvvGmykPeRm3NkcZ35g
         ZF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=INtcSWuYJqZv/51emZbtl4GZQaiJjf0FK2Rx9NjjvdU=;
        b=fYZzU2QszZSz+gAZgl3sK0GgEyHdPKiKeSuH5tvWTj+DY8ZcQWPeJ8vEUAI1glfBvN
         Ojyc2dyAU8/FJL+hIaxwKkZfEQ+SC0gbjujJbq3T57ftTS6StPnqov6Y4hejLP4aeYYE
         RLcj/JXWpajRaoEEFWrR3zGo9kxkLifDVp39IA4K9cxgyyVDsuAixQdaXCVsPak+29SP
         WTXJ6KIu8FVok02MpcV00YZMeoV81o7NPRHQ9kImZ4pjgJemOaWVvZDYGfyvqgoQXpFs
         iaTDxSrnkYpRfdOSEW71WJBD47OFymZLYNq15/b+IFUMDOcqsPEyWZqCcVvykFMyOMpz
         UwIw==
X-Gm-Message-State: AJIora9M2c/Wiwf/odaBwQwZ89K5iThSQc21eU0w0hZemolCICkJecsq
        NdCzjO9Uee+7O3VsZZPJ6V0HfA==
X-Google-Smtp-Source: AGRyM1sxv+0qF++QDNW/7QJglg4BElyh4Bi1+WA1w2r7AwtDUgy4amACvWODEcwnxlDOf3dBJq0Zmg==
X-Received: by 2002:a05:600c:58e:b0:3a0:48dc:defc with SMTP id o14-20020a05600c058e00b003a048dcdefcmr7554631wmd.54.1656330462296;
        Mon, 27 Jun 2022 04:47:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b0021b829d111csm10478996wrq.112.2022.06.27.04.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:47:41 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:47:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        sre@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, lars@metafoo.de, rafael@kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Message-ID: <YrmY292D/0vfIO4j@google.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-3-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603135714.12007-3-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 03 Jun 2022, Aidan MacDonald wrote:

> The AXP192 is another X-Powers PMIC similar to the existing ones.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
