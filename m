Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD16AB295
	for <lists+linux-iio@lfdr.de>; Sun,  5 Mar 2023 22:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCEVg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Mar 2023 16:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCEVg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2023 16:36:26 -0500
Received: from mail-108-mta231.mxroute.com (mail-108-mta231.mxroute.com [136.175.108.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B51554A
        for <linux-iio@vger.kernel.org>; Sun,  5 Mar 2023 13:36:22 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta231.mxroute.com (ZoneMTA) with ESMTPSA id 186b3b43a19000edb4.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sun, 05 Mar 2023 21:36:18 +0000
X-Zone-Loop: b8a3cd5a45b780db9b41bebd1c67e22592b4ab171c6d
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=zQ6HlLcG1dRgIHfcdfrHq9ik3rijfN+qTeq05YiAows=; b=h
        ABZtLmedhN+isSWu30ZXbFZ+0zDrWnJSrBe31eRxDiOs0MHJCpFFDNQetxoS7Zik5qEo3z6I4woqE
        kysv18hWH9sC6HaO0mVHD22JQXSOYHJzgIA0Vx4zZw2jyPso/3PiqY9dD90zEUkhKUA+rxmyEB83C
        UVJm47PyGD5jSKPH/PISKVrEWBzhZA7F3Eu4sPyKq7bgw8e7uV+TbqooqRDxPaRPRQjM4ilWEstGs
        Z69wNdqZGOEdYOcCwRVTYJci7CMyYAlX7C/BsNDjgY+ahLW6oOna68bnqzYdAitpiXYLD5/hVQwVU
        mQazo2uI14NOTwEit2JpN7LXjft5MUebg==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH v5 0/2] Add support for the MCP9600 thermocouple EMF converter
Date:   Sun,  5 Mar 2023 13:36:02 -0800
Message-Id: <20230305213604.4747-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple EMF converter.

Andrew Hepp (2):
  dt-bindings: iio: Add MCP9600 thermocouple EMF converter
  iio: temperature: Add MCP9600 thermocouple EMF converter

 .../iio/temperature/microchip,mcp9600.yaml    |  70 +++++++++
 drivers/iio/temperature/Kconfig               |  10 ++
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/mcp9600.c             | 146 ++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
 create mode 100644 drivers/iio/temperature/mcp9600.c

-- 
2.30.2

