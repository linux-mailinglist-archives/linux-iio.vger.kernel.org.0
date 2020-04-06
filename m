Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1680119F7DD
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgDFOYB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:24:01 -0400
Received: from mout.web.de ([212.227.17.11]:42217 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgDFOYB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 10:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586183024;
        bh=A+/Z9pl5jZknTW9T6YxUFwyyDAtN1Pty0w3A9DheCFU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bvmoW3pzV4GL4GJXBrO+K9SZFcvTtJI5E1fvVM2oRHGrtQdj9aUXRoqEwStnjTu9J
         AAwMywau4e9CGnJoQJacn1VwBo4vZ/Ktg59YzJ8muhIy1kaAOVZ0PM+8IvK3X4Z4AM
         hAB5N5V9a0LXzBbbs+tRh4zRPblvHiCf2MvsscwQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from LaptopNick.fritz.box ([79.214.93.1]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GJ0-1jSZOo0NzC-00CeLw; Mon, 06
 Apr 2020 16:23:44 +0200
From:   Nick Reitemeyer <nick.reitemeyer@web.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Nick Reitemeyer <nick.reitemeyer@web.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Alps
Date:   Mon,  6 Apr 2020 16:13:49 +0200
Message-Id: <20200406141350.162036-1-nick.reitemeyer@web.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XAnolYbOqSRtvq/4irl/ieQvfSn3WE/AUbMOgIL3Ax8Px9V92I
 xsM1KwcVgwd/KP24usPWuS4OKYyMSRyYYcI7F7KmzQR8dFQDPjyY6O9jc5mZQXC1T5HkaBT
 4kwVnKlAol3vS78Xs7beVbcoLHC9sODBS3vnNtScUY8l95LhrktUed3WrFYbT5ekm2c/8/G
 GQhAoqp2TJu2cyGQPUWwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qt91JurmaBg=:uL6cRiHJ7WjioDChJHgbme
 Ghg7z+2syURCIRtp6wa5WnneBLVYzP8uVlYcF5xso51ojPT/Dr1MT/Ij8Eh6bCT9t+UIA8qGe
 HmL3XO2HvBuTLlV8Cn4NhhL4S3RHB6gASezkqVreOrOzaiI5vD+WWw8uduQfsRwiStPIL0ww7
 V3JAWhKDWCTxv1ERS95hCb2AvvdEFYYvkPDEpH/PmNWAe8N3OyCtHAZtAdJEmkvlaKjNd00pz
 O03XpTb/tT68aK4pbglIzzb0GEm2/6JqzVbLpZyGeufXP0o1F6volTYnt8GNVM0Jk2aYakVxA
 +EfOgM6ODHCnGAUtWKIJa0t3EJj0RTWH/Qd9H+2OMHbfmgHQbAZbOWAMFU7JRnUuQGZ2FW09e
 Ms7QzZ5BH/kh7OsVSlM+JxRXBrYmkA9EDBIPI4BlSsRbHeaLDztP8OdXcWl5Bx5a+KEJcG8cp
 NrASn0i06YkWgPbItlW/3ABnpLYdhhdB/W/yev1SxkOaUZYYnvvmAzC9+hnQLwxt7d4I8fSfw
 9u1NTOQA1ihrGMV37qV8xsFz8iYBUuaCQDEr/UXfgbGn+QYHgq6I/N4jb3d/Q7otzAj1UYYCn
 1RKYStUrxSCNN6AhOXTgPdmqyn4qqwWknZ2NbVPSqjMZv8YUwsVpXUuwU+Kfz71meo/nLfTxC
 ohItkQFGl30gXwcgMR/ex1SLBwdD4eH2iG2XEzWST1tAViyF6f/o0g36JTJEHqFIh8jdwrOBX
 d4sULoe+t3rG2/1VNIzXqVV/B2wsPYBopbKFllpUaKlGj26xI4umzDMEYfETsuBWfhMR1MELT
 qJgkgq6pzCXhzMjANd1beSo6din9CVyromqVg5PGp2aiVA8wKXjoT02p7Odb7ymz/AxZ8x73g
 NfpdcbDIz1x6al0dHoPsNs9bjVj66GARrkdDgAAZzOoWUTerDFsu8HQahHEMnDZrj6xxc/L3m
 7/k4/YE8Gps/U/agbGWyUgclfrzfZqp5XYCQt2N2ZySo4fdxu6+YF/1cgCAFAFu17AWyLaDni
 Opq/A8muGxIx1xL5dV+MfMqzzlaCl6W3WLH5uo5YSCKtAbC4PfN+qRrM/XWGmmEfjSj2BSaKx
 xf3toT1ofvgSTNvTJwfSe+VuNgO0M3s8Jj9V3mRzD4dKD8G+vfUK6bvdwZYtBfCyNFF03cIbI
 cVQa6W2w0d3Glh7mm13gOx4Xwwuo3LMnmJsLRyV80oFQPy2NLj5hrwdDvQuqPFO2zJpY57o9X
 H/AM5dxlDVF6lGDfN
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Alps Electric Co., Ltd. is a japanese electronics company:
https://www.alps.com/

Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
=2D--
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docu=
mentation/devicetree/bindings/vendor-prefixes.yaml
index 77fb3c453014..bbccd6cbbe73 100644
=2D-- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -59,6 +59,8 @@ patternProperties:
     description: Allwinner Technology Co., Ltd.
   "^alphascale,.*":
     description: AlphaScale Integrated Circuits Systems, Inc.
+  "^alps,.*":
+    description: Alps Electric Co., Ltd.
   "^altr,.*":
     description: Altera Corp.
   "^amarula,.*":
=2D-
2.26.0

