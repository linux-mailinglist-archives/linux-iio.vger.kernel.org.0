Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F92D4B4A
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 21:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgLIUKG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 15:10:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33435 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbgLIUKF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 15:10:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so2652776ots.0;
        Wed, 09 Dec 2020 12:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lSUDjfb5bNzkXT412gaa/Aus0djPeYvBIqYc18r9si4=;
        b=hnHFN1J1id/LCxParqkBxS6Kjh8Ym3PJqpEm9i7+JO50u28mGTgn2RJfHLx/BEhx2l
         7CRaA3pjKhY0zwmc/lphqVQPpiCKT6lxSx+UTwOP4O1wJmOw1cXokJZLLYxTWVrNA+Du
         tMSrFvv/17+mqMXTOtIZaXaFVz0hXFZjfXA0hELDTzMK8GvygHsXDb3kEAPKwEclFAqv
         oiMxt0QXzWYvKsOig+qpj1revhAIiTa+iEd2cRfR98srQHlgF5ekpL5i8wJ9ebRfuCrf
         +yA9Nn8fejkMeTfFIykJeUNKwqjuvU+bI3olG9PvHBJmY4ACFaVpIF/ab6Du5F5oEnFt
         GGJQ==
X-Gm-Message-State: AOAM533stwXRewHFc5JZ8V5n187Hv/XbRjuUk76ASZFsLASsqELD/8qd
        PpPJVpdTaptLLI0ibqDbEw==
X-Google-Smtp-Source: ABdhPJwgaqPTZRzF/hNcZSCL5Zej5G3KQT3Nclu+rd89mHVgCABup/xSkpg4glkhtlpKUIAm7gdLAQ==
X-Received: by 2002:a9d:5c04:: with SMTP id o4mr3183965otk.372.1607544563969;
        Wed, 09 Dec 2020 12:09:23 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k3sm531200oor.19.2020.12.09.12.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:09:22 -0800 (PST)
Received: (nullmailer pid 858827 invoked by uid 1000);
        Wed, 09 Dec 2020 20:09:21 -0000
Date:   Wed, 9 Dec 2020 14:09:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: st-sensors: Convert bindings to YAML
Message-ID: <20201209200921.GA858793@robh.at.kernel.org>
References: <20201202211358.1517554-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202211358.1517554-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 02 Dec 2020 22:13:58 +0100, Linus Walleij wrote:
> Convert this large binding to YAML. It is pretty simple
> in it's basic form but the devil is in the details.
> Some -if restrictions painstakingly created by reading through
> all the datasheets.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/iio/st-sensors.txt    |  82 -------
>  .../devicetree/bindings/iio/st-sensors.yaml   | 213 ++++++++++++++++++
>  2 files changed, 213 insertions(+), 82 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
