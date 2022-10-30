Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82461612C8D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Oct 2022 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3UIb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Oct 2022 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJ3UIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2022 16:08:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FEEA19F;
        Sun, 30 Oct 2022 13:08:29 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1opEbW-0005ci-7i; Sun, 30 Oct 2022 21:08:22 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-input@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org,
        jic23@kernel.org, paul@crapouillou.net, linux-iio@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>, contact@artur-rojek.eu,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH v13 0/3] adc-joystick: add poll-interval
Date:   Sun, 30 Oct 2022 21:08:16 +0100
Message-Id: <166716040325.1678541.13168867840421275264.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816210440.14260-1-macroalpha82@gmail.com>
References: <20220816210440.14260-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Aug 2022 16:04:37 -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support to the existing adc-joystick driver to support polling
> rather than relying on triggered buffers. This is useful for devices
> that do not offer triggered buffers in hardware. Code adapted from
> changes made by Maya Matuszczyk <maccraft123mc@gmail.com>.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: Update joystick to polled for OG2
      commit: ec3fd1adfda96f42e70dd5f0f69451d642d3598b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
