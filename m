Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6527A2302E5
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgG1G31 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 02:29:27 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:48526 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgG1G31 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jul 2020 02:29:27 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4BG6GD0BTjzMvkt;
        Tue, 28 Jul 2020 08:29:24 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4BG6Fx2YQBz2TTLx;
        Tue, 28 Jul 2020 08:29:09 +0200 (CEST)
Received: from N95HX1G2.wgnetz.xx (192.168.54.24) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 28 Jul
 2020 08:28:48 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Christian Eggers" <ceggers@arri.de>
Subject: [PATCH v2 0/2] iio: light: Support AMS AS73211 digital XYZ sensor
Date:   Tue, 28 Jul 2020 08:28:29 +0200
Message-ID: <20200728062831.1143-1-ceggers@arri.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.54.24]
X-RMX-ID: 20200728-082917-4BG6Fx2YQBz2TTLx-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds support for the AMS AS73211 digital XYZ sensor.

Changes in v2:
---------------
- Fix $id in dt binding
- Document full I2C address range in "reg" property
- Move "buffer" member out of "struct as73211_data"
- Fix sparse warnings by using correct data types


