Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191876381C9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 00:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiKXXjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 18:39:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D2128
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2022 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669333151; bh=tQltvtIUHjwd89cbWA8b7RUIiLWvK0uY9bKeWCwsS94=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=m/5lbq29+YV6wT24pmgTCod59gitLed6J1333BzBErmpG8tgHcI+EQKQCa2xhadmp
         etXdczWKYSdOVCqIBExYgHLkhH/SXYX7NdBQ4IB4WIdjJ3Fcu0jGQxyc9jINpMXbcc
         v1VmzPAjl7b3fxJwfVG3m9StUWnmxrX91upFIB9OJWnHlzuegCEkPC69LO1lzFWLWW
         ymq8fomrC6KC+HRpJt0Ei9DNJEhQBoRtu5jxSa2qP4ihHXYF7Gp0d2zceZmTZA96Gq
         knUOXsXZyLiGqQpwW8U7UEQoZbuRrRrkhMMufgrFI+78xwZoZp3xHgWBBERB/TEEaU
         ekV5NIZeo6dVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2O2Q-1p2DQG3Mz8-003rkv; Fri, 25 Nov 2022 00:39:10 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v4 0/4] IIO: More HID custom sensors
Date:   Fri, 25 Nov 2022 00:38:37 +0100
Message-Id: <20221124233841.3103-1-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VXyM2SoLmQR8z3yYFL6Ihj5vApE7fd5kKObWbPFQU+nY9+EznLt
 yzXoejSD2NsXpLz4HKe8FtvQZoC8AfKp2Ax0OlYv3B//12et9mY58th6ObtwAlDRiAfmO4d
 2VyAFLd3badkIRL6SCGzfc1A2rsFpUeTyUcsEZtpGjPun9ytCrRY6d4b1tzZgYzYmvmX5lv
 B2z+A1onEcGWweW6p1awA==
UI-OutboundReport: notjunk:1;M01:P0:y29D0D0NGRI=;TrYjIm1M++IrrkRrqsO14W802hG
 5/RiJBiNwk2cknAVI8LWq7CdbYvuHsw4tORQ99+6dJP3NoEcfeZo95RW3ejrvaHCCGqH6pyOi
 biq4Jc97XWN6bwHwumng8+wCGKffeZ2wJtzxTEjjGg3L+NXZ3Bjgn4ZsvOJBaFhjdwF0JkQdh
 Dk3r00+6A9Ker5W4vLYxNMCO4dtuh2npEZRmyDK1MVVw/u6ATepj8uV6Wpbp0wUg7v96fIksP
 CNPzrU86Erc8VKhMhnGo99o8vItqxtHp9U6Prn++Ov3imNXU6QTbJ17+BVptHiLuEBzOhFt12
 gyUnwdLuZ40N1BdXiFiGfZILSVjF4J/InbvbGQX+VitqVgd+7yO6LGDnzYZhMm1RqlT79FH+h
 2pdFGEA4mP1ut9Qb99Pho6IHrq/SbAlTxzzAE/KJGF9g3/9+svhvc6VSKQCZLjQ1fGX3f6lCI
 VM6A223spu8ULVlx9ntMiWS/xZJKUS0UYqToLpRxl8Q9H3rgY+VjIkvdaLTltWWJxFVf19Bb3
 4DMlQNxOn//djdV+Jla3Pk34tJBDIirRLolFzYuWMaTQx3TJbbvoNmLMUuVdy3NU+v/sfTnTo
 1v3KG/M+mNiwoMBvIT5B7qLYGADwpspWZZg1EOIEoD65tCuws4udXkc/3ZZ46TO6bvskRyTNq
 GATlUv9G3jRkLdkM1LpbJN3eOXBbozVxPW+adYA4vOVVGUWYQMSbOonpOpRzrKhcD372xsj+y
 iQQKMlQ/AF5WRmVZyFRJopFz5vFOiM5b6UVp4hO19fiRw0u6OkK3gg0uWoKFfVsXnljb462tA
 ZhVrNxh5fMVL6mQs1jQXKSQ9qG30PEA2UEuPaJYcBJ1fDvDvYsDcMvDawbuiAHiiF036t6Kdl
 I7Kss7tOd8lOEdP2niFYLc44XR2Gahp9OE2YKfKhrVYFqWg38XDlZVn+xJQ7YbBQaKnGCXb2l
 31WjnZflr+mQXLky5ZDGnMEKxmM=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

I'm sorry for the confusion caused by me sending revisions as replies.
I've now addresses the points raised. As I'm unfamiliar with mailing lists
any recommendation on making the process more seamless is welcome.

Thank you for your time!

v2:
- Patch 1/4:
  - Remove unnecessary comments.
  - Change return type of functions to bool. (introduced an error, fixed i=
n v4)
  - Swallows return value of a function. (fixed in v4)
- Patch 2/4:
  - Create this 'noop' patch that just adds the LISS sensors to the custom
    sensor match table.
- Patch 3/4:
  - Remove some unnecessary newlines in function calls.
- Patch 4/4:
  - Allow for 1 byte human presence reports.

v3:
- Patch 2/4
  - Add missing 'Signed-Off-By'

v4:
- Patch 1/4:
  - Fix return value and error codes on property query.
  - Document and ignore return values for queries of optionally matched
    properties.
  - Don't modify *known in _get_known, return error when not matched.
  - Remove comment on newly added sensors from commit message.
- Patch 4/4:
  - Clean up switch statement.

Regards,
Philipp Jungkamp

Philipp Jungkamp (4):
  HID: hid-sensor-custom: Allow more custom iio sensors
  HID: hid-sensor-custom: Add LISS custom sensors
  IIO: hid-sensor-als: Use generic usage
  IIO: hid-sensor-prox: Use generic usage

 drivers/hid/hid-sensor-custom.c     | 233 +++++++++++++++++++---------
 drivers/iio/light/hid-sensor-als.c  |  27 ++--
 drivers/iio/light/hid-sensor-prox.c |  37 +++--
 include/linux/hid-sensor-ids.h      |   1 +
 4 files changed, 199 insertions(+), 99 deletions(-)

=2D-
2.38.1

