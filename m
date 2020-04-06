Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE5A19F7DE
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 16:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgDFOYF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 10:24:05 -0400
Received: from mout.web.de ([212.227.17.11]:42113 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbgDFOYF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 10:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586183031;
        bh=PiDxbqvnNA9jmiqIwsZwJ6rZhatS8Q2c4z+g2dNxp1Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BeJNKXIM3RdpNsji1M1Z8pbLAj0RbKSUwH0kGPTYdTszQRTDY3SnleERPFWJSlvtD
         rfhIwyX9a/+NTv+uOX843h6pjLr4+4RI3y/sEDDztMzkcgeLh5YjIxVpvQN4dxPiu7
         VU623Nn6B6Go6tvomZKeR0RnSe0RGKASzkC5MFt8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from LaptopNick.fritz.box ([79.214.93.1]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lcxxc-1ivAO70inI-00i9M6; Mon, 06
 Apr 2020 16:23:51 +0200
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
Subject: [PATCH 2/3] dt-bindings: magnetometer: ak8974: Add Alps hscdtd008a
Date:   Mon,  6 Apr 2020 16:13:51 +0200
Message-Id: <20200406141350.162036-2-nick.reitemeyer@web.de>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200406141350.162036-1-nick.reitemeyer@web.de>
References: <20200406141350.162036-1-nick.reitemeyer@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yn27K62zbxb3m7f1cHPn2ACYg0EyZg1szkitGq5L97UDVJiLMvX
 et5uzP71gA5GSo+BMyhlw05t7AfRUeZ8142CDn3Eu2TDAzFbNE8Ju0Edi8D4wQPdKSzebtC
 hFQ4HC+JkhAMTjizivFnpXrAuKd4LrlD9qqQzR4xI9Ej0lbcp/BT8rI572Sv40f9HDaRzPb
 dc8IVY+dG+hNpDiid0F1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2WpgFTzMAu8=:Whhwk5Q4LfkPS+jm9mUbPo
 Dx34zjrLgl3iWzNZtx7wZO16GtZEFfvz+f8lAy8T4xCprm2mPGxuQNFN8D07K6tXV3tvGLs6V
 ZUNk537ZlDf3Q7Hv/OeaV26Iu/GOGXd5U+0c/s5opfpu8ww6Cg2O5pDwxVgQNhL3lsMSgavSD
 w3weZAnk9gW+Ehqvl2It6LbG49dRRoivln1G+iWtAUSyxmuJyVWxisSoP2FFgLfMCXNgnas+r
 vlaMU3MgYYbShs/zPZIqBHxmqdYlLMmibcxGirn5m/8b1iazGhgVKz7w/tEOE3eiO+LS2SdOH
 vkESyZjkKYCVeVBUgjGYE29dtJn2RMcW6fw1BZpXUkU69r3UU0dkgb1q4NQ8eEF4i8Z+yghra
 V5VG8JzjJRDX2BY6WfJrGfN7gh09i76VPl+m+UTbFfScSFD6C7uH0apieNf1nmUPljLUt3Q31
 rnYQkYjY3lm4kRmW3jD35GRcykvABmKTWIlGSYjk4P97xVfEOToV5MJR0veqpoKclxEb2n+YH
 dak1vWZ/vqsKpXjMcHXOSwFiD/XRaSORbdhfUPQTQMOZYGveDfNp1pkyjdwdKSvp/30NZwYcL
 ikTd9ZwtIPw/kDrS3wDaJ97AVHEjOLCWPTCwveMSO+L95VGmmDzmeOZLAGx6PNkyVv3vZUUmc
 dyjiZ/mf4ok/rQh897o9KYA0eZIjR+SFfZU5hps4e1Bih9PhIw0fBERB457NkIyS5GCIdvaPa
 59vYNcOljt0F0oFTou1+9USw0OXEC/SHRxGw1Sk/6GVwwG9dA2Iy5S7Hz3tuNuSeeng0dmfdi
 b53OMF+uEJhuJaQnbSYCLGCUp4q+ROEozvYOLi873iROvNGXqmluAEVV2EuAYTIqaGEsz+gDh
 ih+HKCflZxLtZG3LiAPTJQDoQ3b5JIlEiD+/rETX/VWWZ3RsxDwoplui1bOP3csw05g+uH4Nn
 j8fgNHapGdEiNcWfLOzignfAhbr3/ZbXMafgC098sGFxll55HomViylJiEsHBo+6ypQDxevl0
 bIPScz4wrJNTr8x6Oi4m49J9uBwLgcjncM3Vnh9jGFT77VNGeUrCGkW8tL4k6o0mgG+wwkyhg
 7NtCDkgzGXZGJ7g6mBZiik2ttvlR96lYDdmp9OBDpD/3Nv01hgQVd5JuwYNrB+ode2ziXp2Mi
 wsRNx30OcoX73M+wNDNGkuxyvYcIaFoel4h9woIpRMBva7KR6JKoYwU+FrAcYyAy3xJAOKflW
 c+r06oIEmB4xF98H6
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding documentation for the Alps HSCDTD008A, which is similar
to the ak8974.

Signed-off-by: Nick Reitemeyer <nick.reitemeyer@web.de>
=2D--
 Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt=
 b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
index baecc4a85197..7f06eff3b504 100644
=2D-- a/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8974.txt
@@ -2,7 +2,9 @@

 Required properties:

=2D- compatible : should be "asahi-kasei,ak8974"
+- compatible:
+    * "asahi-kasei,ak8974"
+    * "alps,hscdtd008a"
 - reg : the I2C address of the magnetometer

 Optional properties:
=2D-
2.26.0

