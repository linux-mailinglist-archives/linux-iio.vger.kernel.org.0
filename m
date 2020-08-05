Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A423C563
	for <lists+linux-iio@lfdr.de>; Wed,  5 Aug 2020 07:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHEF6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Aug 2020 01:58:48 -0400
Received: from mailout09.rmx.de ([94.199.88.74]:48953 "EHLO mailout09.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgHEF6s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 Aug 2020 01:58:48 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout09.rmx.de (Postfix) with ESMTPS id 4BM1C83SCQzbjF4;
        Wed,  5 Aug 2020 07:58:44 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4BM1Bl5x6sz2xFM;
        Wed,  5 Aug 2020 07:58:23 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.60) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 5 Aug
 2020 07:58:00 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH v6 0/2] iio: light: Support AMS AS73211 digital XYZ sensor
Date:   Wed, 5 Aug 2020 07:57:42 +0200
Message-ID: <20200805055744.31909-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.60]
X-RMX-ID: 20200805-075825-4BM1Bl5x6sz2xFM-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the AMS AS73211 digital XYZ sensor.

Probably everything is fine now...


Changes in v6:
---------------
- [2/2] Fixed remaining open points reported by Andy Shevchenko.

Changes in v5:
---------------
- [1/2] Reviewed by Rob Herring
- [2/2] Added KHZ_PER_HR define
- [2/2] Added AS73211_SAMPLE_FREQ_BASE define
- [2/2] Slight changes in comments
- [2/2] Claim direct mode in write_raw()
- [2/2] Saturate only in case of overflow
- [2/2] Don't set indio_dev->dev.parent
- [2/2] Fix error path (order) in probe()

Changes in v4:
---------------
- Integrated 2nd review from Andy Shevchenko
- Use more devm_ functions in as73211_probe()

Changes in v3:
---------------
- Integrated comments from Andy Shevchenko
- Integrated comments from Jonathan Cameron

Changes in v2:
---------------
- Fix $id in dt binding
- Document full I2C address range in "reg" property
- Move "buffer" member out of "struct as73211_data"
- Fix sparse warnings by using correct data types


