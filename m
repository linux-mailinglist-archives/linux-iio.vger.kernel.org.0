Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05664386A
	for <lists+linux-iio@lfdr.de>; Mon,  5 Dec 2022 23:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiLEWux (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Dec 2022 17:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiLEWup (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2022 17:50:45 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB960C8;
        Mon,  5 Dec 2022 14:50:44 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12c8312131fso15297218fac.4;
        Mon, 05 Dec 2022 14:50:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxzHvxWYmZNaSPLEYbPmMtXeESk2K7kyfAJQblqVQ4Y=;
        b=J7EJVj65xEzNemPIjtCvtsbeKGBMvJkD6qDOySW1LhpNKCwB8S4RXKRDLrWrdgEv3l
         XCmSqJUuRidalQ2rr1weme+ZYipxdpnfxX8qILWblZWx7U1EHnqgFgRHzwilYHsvkYti
         JJrNk+o0BFW2szZ6wzO+tv5ooMT7uRwwRPk0ewYsh1Y5tgNYhkwKnhnLJNP2jsFmU6ND
         qp+Z6pqFQ5hCv5nVTNl8Sv0CuLPpeol6ZiDGhkoq+ani0Hz5QcA85eqKR/aE5bBxmmdd
         JYYktI+5pIU8M5djZ3y2V8XclxrqrhrfAbSUMo6gaSHaALa8aoWA6bnyr+0g5p3fqbA/
         X0Qw==
X-Gm-Message-State: ANoB5pku6zBlAoXZX9M5hWcIDKQYBB16yGZJ/mIH7Gc+SugRCnCPVggt
        1or/Iz3tMgsGtH8Uh0X24A==
X-Google-Smtp-Source: AA0mqf7KXJ756pvRNU+pFCeaYq8k5ygB2LcP2STdNxTP3B6jBGxIhCZjdG51aLUleUczY8Cm7yTj0A==
X-Received: by 2002:a05:6870:ad09:b0:143:bdd8:ee2f with SMTP id nt9-20020a056870ad0900b00143bdd8ee2fmr21163024oab.7.1670280644076;
        Mon, 05 Dec 2022 14:50:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y39-20020a05687045a700b0014435b51ef7sm6783694oao.30.2022.12.05.14.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 14:50:43 -0800 (PST)
Received: (nullmailer pid 2831916 invoked by uid 1000);
        Mon, 05 Dec 2022 22:50:42 -0000
Date:   Mon, 5 Dec 2022 16:50:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH 0/6] Add RZ/V2M Compare-Match Timer (TIM) support
Message-ID: <20221205225042.GA2812115-robh@kernel.org>
References: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205145955.391526-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Dec 05, 2022 at 02:59:49PM +0000, Biju Das wrote:
> This patch series aims to add support for Compare-Match Timer (TIM)
> module found on RZ/V2M SoC.
> 
> it is composed of 32 channels and channels 0-7 and 24-32 are
> reserved for ISP usage.
> 
> Channel 22 is modelled as clock source and Channel 23 is modelled as clock
> event driver and the rest of the channels are modelled as counter driver
> as it provides

Why did you pick those 2 counters for those functions?

Unless the h/w blocks are different, this is an abuse of compatible 
strings. What's the h/w difference that makes you care which counter the 
OS picks? That's what the DT should describe. If any timer will do, just 
let the OS pick.

> 
> 1) counter for counting
> 2) configurable counter value for generating timer interrupt
> 3) userspace event for each interrupt.
> 
> logs:-
> Counter driver:
> Counter driver is tested by reading counts and interrupts tested by
> counter-example in tools/counter/counter_example.c
> 
> Count snapshot value:
> 3114
> Output from counter_example when it triggers interrupts:
> Timestamp 0: 24142152969        Count 0: 5
> Error Message 0: Success
> 
> Clock source:
> Clock source driver is tested by clock-source-switch app.
> [ 1275.703567] clocksource: Switched to clocksource arch_sys_counter
> [ 1275.710189] clocksource: Switched to clocksource a4000b00.timer

Do you have any use case to really switch. Doing so disables the vDSO 
access to the clocksource.

Rob
