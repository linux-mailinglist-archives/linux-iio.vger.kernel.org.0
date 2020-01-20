Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4712143028
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2020 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgATQoy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jan 2020 11:44:54 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgATQoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jan 2020 11:44:54 -0500
Received: from localhost ([217.91.205.33]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MfYc4-1jZDRL25RA-00g3Dd; Mon, 20 Jan 2020 17:44:35 +0100
Date:   Mon, 20 Jan 2020 17:44:34 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: srf04: add support for power management
Message-ID: <20200120164433.GA8702@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:gWvLycNxUPsrfbKQlc543piJ9HSAtVHQVSZDVqfMQ5233yg18uB
 YycTa9XcrDLFra4aaZEPuVfq5Um/1CTNOoKrhTE4OP36JNNPMfA+B/mHkKSDTOMlRKSpyDh
 QTIYf85itUhYwCyr5k5FvNIRR+1UNWJfFnvWrzDSzaC1mpgMH9KUW77g2px1gMJ/zV1uwia
 jPjEkCO2BFZaO0tdX1ZqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1DmxnLrgqy0=:mMbAxVGX4GDdscZIyZiVO4
 U3LwVClaeAEyH5SFz4Tnnp179vVlTXXfF45o5rmfKf9c+DCaJNamOnNEkrOHqYd8DZ73RwCRz
 EbOvrP5GYCBIkbGlzrPi7swKZGj28YXqPRBkP2tNkBotlURYcgk5SdVUY09OqUuU3UCw/Yegn
 8EOOOE9KaVDK1o01PzQX4zjSv+xQmFlkcu/zHLB1Ze6As+aM++BJNgzIwqCu8gdAIOMZxofjr
 DwxBEZrq6j35636mdqPueHgVfSR6ZPbhJrQbWzD/wy6VdbbDIEFQ8qNENCkZ5tgw5dlum5EL3
 0hMpm35061JMN7UAFL5z+bq63UduB2zuyEbPSYEqMRsF2/fSRrW2B4Ef/O6g4GNdH1X/7B8/Z
 JAcLC8Y7nHlypedR5RxVi47MtUl8EZld8HfKJhMRMQz6crZKFtmRBPONdqIefWj6ZaNizUU6x
 OA7X7uia6YcW0P8NIVRkpntkY2oaUTXYbX7WSLvVJKwc7+6cD9tLfSsyH2dQrLTW+lSi89KX/
 KCgKJ9+8UUN+WBrXBnk72ftd2gOYsKIv58J1YVaAdvqB+S47SH00AF2smY/cjqXc87sRDIxNm
 D130Pr/GuZIBaPBuX46suADzZiYRHA9GwVdZviUH1qN5+SaPV1FpnFF45ASql5kQ1E6wf6kOG
 40oVtOc3ImiTiCsLpt93/CpGisgWQSovEzUaN1jJjHAawNh6bxVFOEKXf4viRkrEy762jTtbd
 8FCBvwRFOFf6dCyP7aDxKKI0SBLvjKTp3IP2DtB3TfHW9x2BLY93D+7iqjc/uuEkNeH2utJ7L
 mx1dGu3crSHQx+/CqrnjZyovHjSqkT/aCLVbC3u5+HY1B9JoMT4ur9UUuDp3bxbkgHNmeeSt1
 zyVN5Cc75wCvTtzS6niw==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for power management for the srf04 iio driver.
It was suggested by Franz for the purpose of saving energy on battery driven
vehicles.

Changes in v3:
Thanks to Jonathan for reviewing:
- drop CONFIG_PM
- use __maybe_unused for suspend and resume functions

Changes in v2:
Thanks to Rob for pointing out some improvements in dt-binding:
 - add minimum, maximum and default value for startup-time-ms
 - drop schema reference

Andreas Klinger (2):
  dt-bindings: devantech-srf04.yaml: add pm feature
  iio: srf04: add power management feature

 .../iio/proximity/devantech-srf04.yaml        | 18 ++++
 drivers/iio/proximity/srf04.c                 | 96 ++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

-- 
2.20.1
