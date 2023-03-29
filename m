Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E736CD7DD
	for <lists+linux-iio@lfdr.de>; Wed, 29 Mar 2023 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjC2KqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Mar 2023 06:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjC2KqK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2023 06:46:10 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80B1FDA
        for <linux-iio@vger.kernel.org>; Wed, 29 Mar 2023 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680086764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IIoawS2cEwdzSNh0L849uGxIy27juukQ/WXP/fSMp0M=;
        b=c5l+//x9DXU9s9TEafVEWIFMSjfxdGIjScN4/ygH81br1HbObOk40DTdwa0rRlFx9D3Kp7
        d+4eud4kSzMz8u0QwOI1alk9lTsHhOfTP1Q1xfM6oPnectvJFARdL9vMoHGVTdX+MOkM9r
        3R/84cEo9gL+YXCDhGND6bMEUzadT6s=
Message-ID: <f3365b540d6a6789cb3a18cf531e652673320855.camel@crapouillou.net>
Subject: AD7192 driver mess
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Date:   Wed, 29 Mar 2023 12:46:00 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

I noticed that the upstream AD7192 driver (drivers/iio/adc/ad7192.c) we
have two IIO channels with the same identifier:

AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M)

and:
AD719x_CHANNEL(5, 2, AD7192_CH_AIN2)

Both macros create a iio_chan_spec with .channel =3D 2.

This results in having this mess in sysfs:
in_voltage2_en
in_voltage2_index
in_voltage2_shorted_en
in_voltage2_shorted_index

In turn, this causes Libiio to detect it as a single IIO channel whose
identifier is "in_voltage2", with attributes "en", "index",
"shorted_en" and "shorted_index".

My question is, is it okay for the driver to do this? I would expect
the .channel field to contain an identifier, and it would be invalid
for two channels to have the same identifier.

Cheers,
-Paul
