Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC26AC9F8
	for <lists+linux-iio@lfdr.de>; Mon,  6 Mar 2023 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCFRZA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Mar 2023 12:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCFRYn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2023 12:24:43 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E329F5652E;
        Mon,  6 Mar 2023 09:24:14 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfYDO-1qFC5C1a8W-00g1vq; Mon, 06 Mar 2023 18:23:14 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 3/8] w1: ds2482: add i2c id for ds2484
Date:   Mon,  6 Mar 2023 18:22:44 +0100
Message-Id: <20230306172249.74003-4-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306172249.74003-1-stefan.wahren@i2se.com>
References: <20230306172249.74003-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FpRTpt2ZzY6mienThTEbNRfHWBNdsZCyFr8kQjvCTI+RpIK2Uwa
 bnunZRwMmRHkOJxcVfa/1K6T4N0nJojbL4G8dF+v9dhYAX7gEj+4BQrOEQQnqs/7QZZLXdp
 m9eiMTBOWwcZ4/8bpDI4HF5dfcn+KrCIQxrE7HzqYo6SQo0Yjwt5d/ilrrCi0hpgqS9+BQJ
 f3hyNkJPRL1xpa8bEVriw==
UI-OutboundReport: notjunk:1;M01:P0:Ia63qqu8ctE=;jrIe9L5aIyXvRzwzWne8iCjw4aU
 YhUqVmPr5iqvpuP3nwi9a/o1yNPb3wlOhqsNSOvADOChVvsBNn/w6NXN8MZ5o7edDCR9D+Soo
 q4DH+bK5IWVay2tUMc2qm48bOImDtvG/q8tnSI+fIzI/3B+wZYBXGnUaa1U0+fzrPhjzexSjx
 ttomjOHibxbjeGuTOSJSj/LyUC06vUUs5Do2W1ujEanU/4MBBtz3hjXWK6n++YIch1YYlFx2G
 wIgt+7uwfvrmxUVUVl3sHIhJCXnLGtP4KrssOciPkr3zyF7592JDSeF6inFn+Jy/EOQ0ItxMf
 zUrqAHFRzsXQt5N6yCJvvjF9IjmE+ml9gwtOMYzSs1hS4UZSPIVO5Q6N8ysFLWt3/Xi8nV/qj
 jFQDmyaATHEQd11Jgg9CkDb7TmkbdqLnS7fEyzGR4ZBzRyBMOuqo+OiKbhT9kv3qQIp8jPe9P
 9IfEtwmDpqbzZ5oPGvhpPpi9UqRoQVxcA+mh4J2Jl/io0d/YXEDLrTzzsnBLGYHYyZdhbIDYH
 7QFWTzQc2+yZ4xFuXgYSRL0M08HzhrOSkI6BID2AlFsSgBTkohEA1hx08acbX4ob6KYrDBVmD
 TvWnhB89uDVHJR9Wi3wWd57J8GDyerfT/kjr6McdABQD2ApdO/IyWtBnMNQhZbXsIrGzjYw9k
 rW2eGs8GSSyUccWDCelRyhl/yMwWmLC5geTt8NghuQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Wahren <stefan.wahren@chargebyte.com>

The DS2484 is very similar to the DS2482-100, but also supports a
pin-controlled power-saving sleep mode.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/DS2484.pdf
Signed-off-by: Stefan Wahren <stefan.wahren@chargebyte.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/w1/masters/ds2482.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/masters/ds2482.c b/drivers/w1/masters/ds2482.c
index 62c44616d8a9..6f6df686e9ad 100644
--- a/drivers/w1/masters/ds2482.c
+++ b/drivers/w1/masters/ds2482.c
@@ -545,6 +545,7 @@ static void ds2482_remove(struct i2c_client *client)
  */
 static const struct i2c_device_id ds2482_id[] = {
 	{ "ds2482", 0 },
+	{ "ds2484", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds2482_id);
-- 
2.34.1

