Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E2DF2EC5
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbfKGND3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:03:29 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:36291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbfKGND3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:03:29 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4yyQ-1hjq0Z1xnY-010xdN; Thu, 07 Nov 2019 14:02:56 +0100
Date:   Thu, 7 Nov 2019 14:02:50 +0100
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
Subject: [PATCH 5/5] MAINTAINERS: add maintainer for ping iio sensors
Message-ID: <20191107130133.asgoinzne4wpvx2b@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:roj6/uW2rfWs1vtm4BS1f4RBniw3LM9usYRsDw9ryAHb5sWJl6S
 wR/Sah8Rcd0r+wsmEsrkn2d2o5rnnqutq80WhTuY193F60xRSsRHLKb8bI07jXL8DtNiWEE
 LJmF00G6+pB0tC+xo6sxWCVC23ZCBPKtdc944ob8BWaK8g7d5hUUidsNV1gnaUe7O8HZ0nq
 DpGl8DQ6nz7s8E+E4QpbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A6AJSlv7As8=:AMHdnxsg19HuEiOij2fX2I
 zM2nuwPtI8vqgqnS5cJaSpofBe5DFIWdKngNtM/+b7J0S1CrcjlTtg0NjxiXpLPQiqr+uC8pj
 SiBfgYOU7M8lGHXHJ10UzLh5QAkJlFmgGO/iFUGICs+pOTJPxUGhEv5Rmcv9CbnuXw2gjbhLZ
 8l/AEn/vSWY7VREHZsc64JbHByRckn4F7SXdidNQUywy0UWSruccymI/oOytR8ETGuznuWYKY
 L/UGuQSlz5ZW5EKtnt5X+FmL8UMZDwQ9gEGWMMFFQzC3mE7v8hGo4+A/ZAFWwacSZzn+bgvNv
 rL1GLc4NEENh2claz4z7KJEwHIFO6LjqdpiEjiCFYnKj4+3bxJzbkwLDw987ozjKrvkPxd+Ea
 j72lJ4m0g+OP1MdIIYlNABHsfHa1UGaUNWLBptZA88Ho7yeuMbujdYYtARBYgtOL5RKQUB/K4
 aGizZG06nOdakKT1V18Y6jMtBQq5fgD9GkCdVSx51FeTwzeun673EynwLFBPnbTwDl/V2TtMz
 AllSnwF6Oe4ejir0MDQZ1kDG2crqJaukkpYsATKLrkYZ54k3zhflFOakCAcuW0oToC2zAjFgE
 Z9SnliU07qA12xp6sfKxpon/0NOehKQSuvdYeiO7Bgjk9BaxWt3jKYMeM49wy91XM8nYRXHeb
 aCjuUYJbqpx75ew5DrdHNH6uQJCp0FCLnyX44XFrnQENYk5xoIEmi69gcYCBLPLwL7ihvl7Lv
 gwiq2uGW1hkf80MWsgKDh53mUsEFyD0xBIQKmT0RYiwZ88FezFaQkEe/0e68RwLhlBrE9deKo
 5iaR+hCY0UcmgESdegfoVysg1gMjV5RYe1VFpIcUZ/blYBRn6ucQZsDKto4gKv7Y1KM3yWJ4/
 Ssx+MPZ6HxjlxG2Bw28Q==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a maintainer for the new parallax PING))) and LaserPING IIO sensors

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6c34d04ce95..ad469adffb99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12264,6 +12264,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/panasonic-laptop.c
 
+PARALLAX PING IIO SENSOR DRIVER
+M:	Andreas Klinger <ak@it-klinger.de>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
+F:	drivers/iio/proximity/ping.c
+
 PARALLEL LCD/KEYPAD PANEL DRIVER
 M:	Willy Tarreau <willy@haproxy.com>
 M:	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
-- 
2.11.0
