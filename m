Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219D71B194E
	for <lists+linux-iio@lfdr.de>; Tue, 21 Apr 2020 00:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDTWVF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 18:21:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45629 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgDTWVF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 18:21:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id i22so9583437otp.12;
        Mon, 20 Apr 2020 15:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJ0ZsBgxEkcMHz3xmP0pqIOLKyjGmk0/vhj0hq2pCQU=;
        b=Jh0ispFOcWOjL9fMpVLuvNJqaPeWZnOEePRhMpacALknWqCNYPz00GdBiVQzcDMt86
         pzVF8/DhDI/eexg5iDrt+N3kD0h7A1z6RGlYYzkLQxPPiX4REkSc7IzfS0t11SHo3fj3
         IhiOQOkY3LZNw/AjMk9XGO+IWE3YGpmHVqYw65amwlz3ExTJTc0ZU/K71XdudZPxCYNO
         LiKA51hlT9dZ0imr1SjP/SXa5EcZ1PfYi/hYCGpMwjIcyXTu0eKgusuKHbK+7T3JcnCR
         rnm1Sb6cdrRAaC55qNXGMTOULQzzoqjyIXs4Hy2JyF3s4n+0QgSF+EztDI+ycccQaANO
         zc7g==
X-Gm-Message-State: AGi0PuZo+mlWaGpRc5TgwDHST5+ZwVOVXvxjfh5DmfFjJbqzQ14A2hQN
        QyR4YyVDhpnOhfvNvsMRFw==
X-Google-Smtp-Source: APiQypK6mA7ViCuT9PSsCzl82bf8op0UEzG26RywzG77OoyLaJIecAesBlogXZYyw4vHODRoiQzYoQ==
X-Received: by 2002:a9d:5a10:: with SMTP id v16mr10849175oth.253.1587421264232;
        Mon, 20 Apr 2020 15:21:04 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n184sm198794oia.40.2020.04.20.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:21:03 -0700 (PDT)
Received: (nullmailer pid 3065 invoked by uid 1000);
        Mon, 20 Apr 2020 22:21:02 -0000
Date:   Mon, 20 Apr 2020 17:21:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: counter: microchip-tcb-capture
 counter
Message-ID: <20200420222102.GA1214@bogus>
References: <20200415130455.2222019-1-kamel.bouhara@bootlin.com>
 <20200415130455.2222019-3-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415130455.2222019-3-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 15, 2020 at 03:04:54PM +0200, Kamel Bouhara wrote:
> Describe the devicetree binding for the Microchip TCB module.
> Each counter blocks exposes three independent counters.
> 
> However, when configured in quadrature decoder, both channel <0> and <1>
> are required for speed/position and rotation capture (yet only the
> position is captured).

This is a child of the TCB, right? If so, it needs to be merged with the 
TCB schema Alexandre is working on.

> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
> Changes from v3:
>  - Updated the brand name: s/atmel/microchip/.
> 
> Changes from v2:
>  - Fixed errors reported by dt_binding_check
> 
>  .../counter/microchip-tcb-capture.yaml        | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/microchip-tcb-capture.yaml
