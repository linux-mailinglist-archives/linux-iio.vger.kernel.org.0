Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C79426287
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 04:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhJHCsY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 22:48:24 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42683 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhJHCsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2021 22:48:17 -0400
Received: by mail-ot1-f48.google.com with SMTP id c26-20020a056830349a00b0054d96d25c1eso9944725otu.9;
        Thu, 07 Oct 2021 19:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=E56GHeo5EYYVQaTEhgHwF3Ub99Puf3x5uCXiUl1l+oE=;
        b=b0Il2MVty4fxTRmH+fcBxEIc2ZNHNO+c7B6JG4PGM59PBW9XpVzFv7Ld2pcX2zYKc0
         9KKeEwysgAlnXLfTpWW7zjR6gD+N+hEkmHZjRjgtgBS69QqtnjCKOdpoDkAfH15tIwv2
         8ftPaiEMk6dByNX1UKzvrjXFgkqwc1bAVpEr1R/qH3KErB/pO6mFmkWHgUw22OixEExw
         SCJOVS+/WnkNVr0liz/88dI4oOGofTuGi9jGk9cBGbAiiCQhIZ3Rr+1U919S+y3aVUi9
         Du7VKQU/6+CXKsPBMBY+EoU2e9frPPYSPeA511aX7m/sCs68510CSWGHpnA5Sitvq0uH
         IFMw==
X-Gm-Message-State: AOAM530rJCHvxJPO1lSlPLrOD81C3xpSEq2mXogfRF28IiHbKY7znhYz
        GCJjclrAZf8MAghS2drmV8RBAMNV9g==
X-Google-Smtp-Source: ABdhPJwSR7B2FeQmrDivbTN4C8wOOGEINs32TY3AJk10ZcXNBndKFGNFVJI5dl8eDVjy5EN1OGB8Ug==
X-Received: by 2002:a9d:84d:: with SMTP id 71mr6750057oty.190.1633661182896;
        Thu, 07 Oct 2021 19:46:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w12sm229349oop.19.2021.10.07.19.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 19:46:22 -0700 (PDT)
Received: (nullmailer pid 1409600 invoked by uid 1000);
        Fri, 08 Oct 2021 02:46:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        peda@axentia.se, lars@metafoo.de, jic23@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20211007134641.13417-3-vincent.whitchurch@axis.com>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com> <20211007134641.13417-3-vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property for settle time
Date:   Thu, 07 Oct 2021 21:46:12 -0500
Message-Id: <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 07 Oct 2021 15:46:40 +0200, Vincent Whitchurch wrote:
> Hardware may require some time for the muxed analog signals to settle
> after the muxing is changed.  Allow this time to be specified in the
> devicetree.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1537724


adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc10mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc11mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc12mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc13mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc1mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc2mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc3mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc4mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc5mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc6mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc7mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc8mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

adc9mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
	arch/arm/boot/dts/at91-tse850-3.dt.yaml

