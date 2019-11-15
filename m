Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AFFD737
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 08:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKOHoj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 02:44:39 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOHoi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 02:44:38 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMGZM-1iCCAc11Da-00JFS9; Fri, 15 Nov 2019 08:44:04 +0100
Date:   Fri, 15 Nov 2019 08:43:56 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: add vendor prefix parallax
Message-ID: <20191115074354.uanova4tomgwofgg@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:BANQnTLmM11JdWuHk+f2usdySofhmleBOZBH9+B0lRvU48xl4v+
 tDXrArYElBLOxl7kePqOuNA/F3W6TDXwUv5Gs4MnkgZrTkxvLbOeAyaWP5hglvM2U7gA7IM
 dqCCWw5DellDtPg4MBLLf3UyJ9ug868NQoEHnt1g7mWb/1iuea2XmjbuCJUV8kZBr4f1+xs
 RktH1OV0q0y/EVZ/rJGAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bwnKK+5gh/0=:oHmi3tRaf4n+GDTBk1ivpp
 ZU0X9mRPWtYoOtFzvOTJFUmOAEPsboWv9qB0uqrJXanYzgg0nHswNJe1jlUSQ4EJ8ZNnz4JUI
 5TNvTYJ9wIpglvXGaBOkF//djz4vQHXQ76hkdC07TkL7QCWVRj9f0cmJ+bN2IikSvp1GR5NhC
 pG7+Wf0BeehhtW5tX4vtUdq0QLNaixkxhtDq/qab5Fauig6dQYyXOEQZdJJvMypBElYtvd48H
 ipGnjNfmvCc05Jd+PCU0bFxxqMB+Ozd7LOJPl/zZgvTGbDCYIiy4VrLHTR8hnYYfJjUV6cq/S
 2f62N595Wvj8yR6opLS9gZZ+RiZUb1c9DL6ZQqRuHoDIWU3yg8yV7fXN1uQIJC79OPXsN19J7
 G4rGYh9BYeBvy4qZi33edxdfd+iUhjVWj30nmHh7A/CcHBDBsw5OE9ylAZCtU4YgLFHVE3APT
 5xiJxnP8oLakLc1uq0A3llRKN3pRLDP94oX8BeZZtbI8zuVHzwzxMDZjb/7c9F4b546OogVs2
 mv9TmEZEgeDN3zOH/r3WFiQBApmuYLpG7ReTXhWLsyiF3VGhcLz2wCKS+ss2LAr1tGMkbnLBk
 8E6pXNvyUru11GH57hIDSKe+kybIjn5B9IGm7hRmPmIHpfrG8sYazpucEmZKJYlhRZAWDmpG2
 tjKGJ54CNCja6x4rDQuj4u9msWuubcxKBcaJZrFUpuS4G71/5cQ3ujeWHcGCzK926Pz7qD1M0
 Ako1NCcB9L5GPwExG6XcibNJw8LmwtO58I2Y3f3UVyWnvpW4L7iB1zGOb6UOWLNjEFCMj6lEb
 +8CAN2whjEI/55XrvRld6fyRk0YPB0GyQNgD6+aKIbOhU8Q/7LBHrX/LbxBEbS/YtnKoT1Mpe
 MpYGQ6AWPTraRBl2r8Tw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add new vendor prefix parallax for newly created ping iio sensors.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..d3f9690e1e4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -713,6 +713,8 @@ patternProperties:
     description: Panasonic Corporation
   "^parade,.*":
     description: Parade Technologies Inc.
+  "^parallax,.*":
+    description: Parallax Inc.
   "^pda,.*":
     description: Precision Design Associates, Inc.
   "^pericom,.*":
-- 
2.11.0
