Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5A1E136A
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbgEYRd1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 25 May 2020 13:33:27 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17378 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbgEYRd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 13:33:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590112056; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=oGfe+QdtlGDYI14677wMfLSj92XXbM9Lhmo7BWxhU0I6kbG3vMw40/sYJJzNMqT7N7lCCHZ0J2umuq4geAeQckEdL2ISG9PToYq7ZcFH1aln/C+DPLWN6xh1BaAqW3YZD7vt88hUIJMTUHaCfwInYLj5/NlRT5fqB5V7gQTC4VA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590112056; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=oN4KLkGs+p55XvRD7sfv6wRXXmKnfQpRoDquzCJfqvM=; 
        b=OiJ7p2bjdPV7YIhnzlH0CpfCxsG7Z3Sw8Wwe9QSJ+a2efSqX0Om7d5WtXPMMEHfWEihaCK61fGa9CkFe/iBGTruVyK9uUKFH+/VbBAbi0syBhVvvhBF2HOzcjvZeFvtenEvl7rFRi3CtWZVURAg7VhKo4aU06XD1G2vUSBaV7gw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-96-255-47-18.washdc.fios.verizon.net [96.255.47.18]) by mx.zohomail.com
        with SMTPS id 1590112054758503.16101315885237; Thu, 21 May 2020 18:47:34 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200522014634.28505-1-dan@dlrobertson.com>
Subject: [PATCH 0/1] iio: accel: bma400: add support for bma400 spi
Date:   Fri, 22 May 2020 01:46:33 +0000
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Bosch Sensortec BMA400 3-axes ultra-low power supports a 4 wire
SPI ditital interface. This patch adds support for the device when
configured for SPI instead of I2C.

I was originally hoping to avoid using a regmap_bus definition, but the
register reads from the device are padded by a byte while register
writes are not padded. As a result, a regmap_config like the following
does not work.

const struct regmap_config bma400_regmap_spi_config = {
    reg_bits = 8,
    pad_bits = 8,
    val_bits = 8,
    read_flag_mask = BIT(7),
    max_register = BMA400_CMD_REG,
};

I used a regmap_bus structure with read and write implementations to
work around this, but would appreciate feedback on this approach and
my implementation.

Cheers,

 - Dan

Dan Robertson (1):
  iio: accel: bma400: add support for bma400 spi

 drivers/iio/accel/Kconfig      |   8 ++-
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma400_spi.c | 126 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/bma400_spi.c


