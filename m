Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5953E04A7
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 17:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbhHDPqv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 11:46:51 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbhHDPqu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 11:46:50 -0400
Received: from localhost ([31.220.117.74]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MlL5x-1msJTQ3krt-00lmxR; Wed, 04 Aug 2021 17:45:53 +0200
Date:   Wed, 4 Aug 2021 17:45:50 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jiri Kosina <trivial@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Slawomir Stepien <sst@poczta.fm>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: chemical: Add trivial DT binding
 for sgp40
Message-ID: <20210804154549.GA3223@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:CrKk4+CxORokZ0dQnPDoLkZhQSIy79eAhrhmCbP4jWiq/4RmT0D
 j++vDpnnsqQpILdizZJrPyVsKF17StHJYz8xmL9Ha2ZOsAUaL6cDL1RcflxGxfYK6dPQhIB
 5xHnGskA88HC21C2sY6FstrBYGHbvQJVxDB3tIGNPGrScROzlFNCGvBCYwXK1L6Nwh+6LI/
 GdAWuMWY9GUe98mmsvelQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zkV8I4A8ESU=:PgkqEc9D3JTp9FpcQ80kL3
 5u2JD4X7VpRjh9PUZGVzGbP51p6ddjujrLtrcSc/e8AjL/u/2gv/OZgftllLZ9AleCPaskzLe
 uoYDo4sli50+5V7kN+uXuA8Hq6bxAASWJaXVHEiOq5tpo0G2Y6J3kznHRuFhYVO3j1ocxITIJ
 xVwSyn6s7E91zE+ucQZU2Mtk/6u61KhFAwrvcP5oAQpDKfwuYhFPyLrHq/XOFN+lRSPYrbAtK
 TzRlGyNTdp7pPO2e8Vl1rUWrXA3boOcNfMkjI9fy0QBFcz9SRU/mxJkW3K/3IORzl8mPqXFGe
 CW2Zv5duY1CT2gfemjIlJi7e8EiluYDsOWmS0HY3vBVjVUjFB1AgReF82lQhWQU/kuNZfcRaU
 KV8+gMqavWqOmTm0u71rUyQWJQvnBDf21dUhEAyo3komD59iLBDvjI+b8yBMq1VMpOSwS/chq
 NY5AtNHLLONq8WqYlex0AjHnsDHcS2IMRguH3tJlFwUbztJQki9/uKr0hdqJ3b4YgAH0+DdaV
 bFwvQ5JYiAdGJ673sSZ5sSLYi9Gp2405aI83atwU+fJ/ZR+QV9GG/qC3kJxbuXd7f+R0eOpRM
 GVKKC01jBAsDOSo1Vk7CJYzh4BlPBrVizkUuIE2eeb759D1mvzkwlKL48U/E8tRFLpcYDJaDz
 BgMgjbCuNvwGxMomCzCxxnJ8HpKAYvm4aKySyeZSvNStWjP2jxEGuZx4Lur2Bs+ghLWzCpghn
 QzO8eZulbPAgrOzPl7CAZVh/0VygLsWDPHKb1fzCqirVA+ylMGanR2SW054lwGjKPArlduyIr
 Bt7jZNSpbpAv1MsTldPPy2DBzXBQz4U7ogFrXBQs6HUMK8DgT/T9TuQuc0heYwBuVyeanq+
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree binding for Sensirion sgp40 gas sensor to trivial
devices.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 919a4bf03a5a..be313b6b4f81 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -269,6 +269,8 @@ properties:
           - sensirion,sgpc3
             # Sensirion multi-pixel gas sensor with I2C interface
           - sensirion,sgp30
+            # Sensirion gas sensor with I2C interface
+          - sensirion,sgp40
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312
             # Sensortek 3 axis accelerometer
-- 
2.20.1
