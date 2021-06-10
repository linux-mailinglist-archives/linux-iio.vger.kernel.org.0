Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DFB3A2C0C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFJM4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJM4C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:56:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2FC061574
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 05:54:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1lrKCC-00032B-IF
        for linux-iio@vger.kernel.org; Thu, 10 Jun 2021 14:54:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 79B4F63840F
        for <linux-iio@vger.kernel.org>; Thu, 10 Jun 2021 12:54:02 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 4A0D3638400;
        Thu, 10 Jun 2021 12:54:01 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 72cfa48c;
        Thu, 10 Jun 2021 12:54:00 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de
Subject: [PATCH 1/4] iio: ltr501: fix regmap, initialization of ltr559, endianness and mark structs as const
Date:   Thu, 10 Jun 2021 14:53:54 +0200
Message-Id: <20210610125358.2096497-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

here are 3 bug-files (probably stable material) and 1 enhancement for
the ltr501 driver.

regards,
Marc



