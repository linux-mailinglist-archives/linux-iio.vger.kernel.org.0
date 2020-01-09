Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1D135475
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2020 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgAIIie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jan 2020 03:38:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44383 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgAIIie (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jan 2020 03:38:34 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAwPf-1j0inL3jy5-00BOt5; Thu, 09 Jan 2020 09:38:19 +0100
Date:   Thu, 9 Jan 2020 09:38:16 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200109083814.GA5368@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:i0uYSN5x4RYDxO54mGdxNfJs2LECSJYdO+xju+pRtqMSxWtOwBp
 J0GjlVpxXHjPASKsW00v+BwTvSHRy8eqi5owOVNgI/7XHKGuseioBFn6LME5jlzeNdqgKw7
 Uue70HvQbkWlRgHvNx0VHPDxDigaw9j7OKsyrMRIEtba0DQBMbXy1yhwBsv6FdotxT6TTMk
 oFqG5mPNhk7k5oR1e7LQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FquxKpnqJm4=:lHu8UgL10UpvgdsVrwfcbZ
 TaPydOcy7cM8g1p/P5RzGoQ95TsouJtMPX3lTBrlZXT787abgFeBCg3o6ShXqXt+3ABR4UtVh
 9Vh3BNzkQL4+MV6TDKskdF2VF4t/2/HoTqlh+nXvdEUkCbGbwgappnB5zMSI9WF/auqatx3Sj
 LK8VwjnbabIsst1fVt7bRI3R7rsV0jrYi6kmhuwTsnKznjgfCyzwYDO5HsvV6xeRGydvU6Zgj
 nvitKKqEaunBIayTKd4HMNAjHNmBrMnu07omiKsgAAYNksGTu5wwWVuC2JLoM/iGp1rbI7ALW
 O6BsuSxuM5Ie65h0uPK9ootEfiq/GJ5kPYjwu1TPxlqYO+6RHBlZ1pu5OslrrEfZCzjITMtd7
 gAqZ1H7bDrG+AOSJL87nRi/igm6OPukFshJhmEh47kt00+UA4LMO3fg2u4DP+mMWEFMoNxjm8
 Yt+ujTYNel2zzJ7p6f0GQD2ZR036P1uguqY645IKrcuR5A1G8LNw9lExdIOXfNvuHushrSzrN
 Emu0M2MBnBZusjrnY0w9M2puUX8AuR9ZJQc70JA9e3DY8YwmdgzSnY4IeNKIduExhtn8TaODO
 Z0sdqt+3DgAd/PmJX8+mYUHJm/k3rN2BIZ6eYB6kI7oClO/vvEo/05QXprEyJZvsojxzvWGzF
 8PEW+yb9bGbR2Vrtgeymo6rao3zXRiVBSZU1324YRMMLZH4dE5bnYTnj25ZmD/SJUVuE7fmI+
 X+lhEOfm2JcuTd4r3aXr0I7MDmxugOoXJaES1fFh467XHMdmm4jezs2/t2i28KtfU+6ET4zIu
 uVb5JvubtHfsIFEPHVNcHCdLWrDytdVUPmaNye785czfNjqnJ4Rz5hqaR2zKyBQCUa5N1qT4k
 aBr/tih0Hi6hERZbdUFg==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add GPIO line and startup time for usage of power management

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 .../iio/proximity/devantech-srf04.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index 4e80ea7c1475..8afbac24c34e 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -51,6 +51,24 @@ properties:
       the time between two interrupts is measured in the driver.
     maxItems: 1
 
+  power-gpios:
+    description:
+      Definition of the GPIO for power management of connected peripheral
+      (output).
+      This GPIO can be used by the external hardware for power management.
+      When the device gets suspended it's switched off and when it resumes
+      it's switched on again. After some period of inactivity the driver
+      get suspended automatically (autosuspend feature).
+    maxItems: 1
+
+  startup-time-ms:
+    description:
+      This is the startup time the device needs after a resume to be up and
+      running.
+    minimum: 0
+    maximum: 1000
+    default: 100
+
 required:
   - compatible
   - trig-gpios
-- 
2.20.1
