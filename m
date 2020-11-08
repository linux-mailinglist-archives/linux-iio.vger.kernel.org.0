Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC42AA8D2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Nov 2020 02:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgKHBhw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Nov 2020 20:37:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:50591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgKHBhv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Nov 2020 20:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604799467;
        bh=OJRzNY9FCDnqO7m8Jh9BpsumethkJGJdCu0JeI+/i4k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=HJXxWxi1DxPWll2qxRfHiVFt9MqY0WpwoZsymHbjgMcO0CHBqK12zs9p0u268QaYX
         czCPer0RLyLg9PKeRc2Mt8Q58LT9vYRsXH+TDraiHTEjXU+Dci2AG62tgTvgxRs7fE
         gKGYW09Mp7PKpnQoDE/EOhIEokwzJnophvmlEDeQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1kT4my100t-00CvtS; Sun, 08
 Nov 2020 02:37:47 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] MAINTAINERS: Fix 'W:' prefix in Invensense IMU entry
Date:   Sun,  8 Nov 2020 02:37:38 +0100
Message-Id: <20201108013738.1410528-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5lvb3f7QU8YqaulPyssVGO5ssbHfXSd7xAzIC3Xhjn8Urev59G
 HAsgIv9cauwQekJ1S7uYlaDysgn9DgB2UozJVSu+4/AH6crnffPV34VIexbVaMZBxla5d1t
 RF2oKFJWF384+/lhV8mkM4H9loOr/T1Fky+sDZKfF7VWtJVb5hToUD7ZlHvObBIgNtLYPvG
 kA64O+NeyQcmi0Yi987vA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KkL6WJH1Stg=:2qmv3e41lE2fwnLdTPKVvk
 E26Dll0sna0LKF84wwnKqI5r+VxSODlrWoP5YFqBG6w2p0ZkkQVcx3UfMstGA9UQwLa4kNTmh
 r9BPoXJ7uW4fAOSzn5B0raKS+oKsA35TgLh6RTSMYJ/MTZCFD2J+B7wd3pAhaKmd3NppkTHGi
 buNkhZlplDzVVfV0ZWiUsYtYbs4bgDQ6MqN5GEb2n7fWjP0Khi8BAdf5WkaE7+8EVe9nxqejp
 WPfPU0SjLbz4DpoxijxB2b7Yp0BKqqQQZ1xlnV6dziWCw7PkxjPA111fMkAJA+ypG4eRW3523
 aYTxYfBStDixr74s4Js5eOIa+uWwf2+SMWfM9xoO1cr6qHwJvfe0YL3f21YyF1IMIP8MHXlbI
 jMGQZB2Qac0i5spo3QC9YMtoqbKCfW+txb5kEEsQHZtJvuOtAp+M4zXydjmPaGQfIjlvhanDP
 0zp5Ym9eIoZ2OakA+xF9HJyTF7nDiUq/bLaIBPzmZQcrGjP50TxkuIuebfmmevl6gW+sTMhPp
 cbOVedZStFP+iEtuVq441Kqp2SsZQMXqS1RFkkHwizRIlAXqboN+7RouzTRI3E46/FgmLyGE1
 LIblXkmIU2nihtzjuhYLtJuPWd5T7C8XPoenCD3Vo7oXtMn2W5dQTqwjtTL8B8mY5yO5e278V
 y4gmNBfuQ9/3tDm0vfEjKKlAgqbvVRH0BLtfXbysxZB9gohro8ngP/YQ11OiReF8ofvLndYJS
 nGJd2WTH1eHSOgyQYZYLFf2Ce0pWZeIkV4qc7k63OrltxlZsK0c/KEQuJPFPk5plZwSGfYW9R
 isHKNLDt6bhTcjyATvXeFDaC4x5ftvyyAI9jp+068yvdnfqQz7tPgO14j/OFz5II5WeYfLcEZ
 cD+zbb2mISFsZ3nV0mcsT81jFyMJoBu+GLlAj7/1E=
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The colon is missing, which can confuse scripts/parse-maintainers.pl.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29d..80defad325f31 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9160,7 +9160,7 @@ INVENSENSE ICM-426xx IMU DRIVER
 M:	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-W	https://invensense.tdk.com/
+W:	https://invensense.tdk.com/
 F:	Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
 F:	drivers/iio/imu/inv_icm42600/

=2D-
2.28.0

