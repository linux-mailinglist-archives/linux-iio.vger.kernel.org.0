Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7967712E962
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2020 18:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgABR1i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Jan 2020 12:27:38 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgABR1i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jan 2020 12:27:38 -0500
Received: from localhost ([31.212.60.142]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MdwRi-1jKkJE2ym6-00b3zf; Thu, 02 Jan 2020 18:27:18 +0100
Date:   Thu, 2 Jan 2020 18:27:17 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: srf04: add support for power management
Message-ID: <20200102172715.jjdw7ehymawixpds@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:VGGLwN4dWju6C54bbKZOEM379zMZFML5+TBBQoMMgfDkbX3PL1e
 R7ndM1JPTz8diJ+550ugcqzKP7TXG3Xh3583mZYfKHXiwI5F8dxfJA28+T2oLB/Jr/sZDAl
 jar9YVhaP05bkJubaE7oBD7UxORZ3OajROVlMQyL52C4OGR0KWwrvYkrecZ+9ippvUjDrg9
 98MtRpRLJxDIvylVILUnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZRoMXqNpmrY=:JGlqggv2fcoZkFnWil8TeN
 Nv60ECKRxfMQtG+aetJfpxultl+08d9lw63USsDHKAmNPjP9YtZgg3J6kl9oXPiUEsErilfob
 JqmNmd+mVQmC9EuQvWhcqcgZ8UguQ6sNW+81E9PSRoq2/Dt8HGQjgq9RG33MyCmngeCzvotSC
 J8553XKp0haclSs+LZ+PMHorKzXkPWRRGSYETI9Dctb4J5XvmtkLLjhejxvb/qQRDLrqP2Bzv
 1J6fVnnW54bSlfw4wmyn4PvPbrUDnUaiqF/+TdU7//cvYRqlG8xav2ogMf8Ifi1LULUdkmw11
 eGfShHqMcG7R77BmAFqyaFRFTGrRlqwfY7krz01bffS7JILm/oW9TRDDA8QEGCjibzfSe8BAy
 +KgqhegNE0ZjpeS3Uk0Ro7DcaObycEb3a1SSWyPXRTZlwEEq3mbvRQRokJ0Zv4AKVNSlSjCtF
 nqz1vYe/moDXncCIb0JE6+ORNepRg4eDMM0zQD9owKDWw5A+fHcsWXQNhYMHKt6YKP2e2a08P
 WO4ov3RwgiPWiPHOH744CCxeWaZzu87lxLKX8Klg9mpmH7Ti9vI7tYDiu36kVUBueqqqAlwo4
 5kzzQjKDzNTS3QgPdkQiqa7HlpyYpihTbALaQ9vKs/2rcEQTR7iVKxFzvw7kxxYH/lY5vPk+h
 cbdIQkyYz39QDITe20g+BHEJKTwdMtpGwKHiJbQjoRaiGmsb11pgy6+qG0vMnLGr1VoidFexx
 5UPAZ/vQstvDGmIXe5JCAJc29+dt3wBfqoGHqLtopChQxQsmEIrIQLvKoF84fLC6h0vTPeJR+
 kUWZpLZeufqpWHAfML5T8sbscDKeGEe1NVXogI9OMLF5zGSZtlgDnZZ+0cqxvJ1YjFxjmsTX4
 mPI9+jePWjxEgOTqSkDQ==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for power management for the srf04 iio driver.
It was suggested by Franz for the purpose of saving energy on battery driven
vehicles.

Andreas Klinger (2):
  dt-bindings: devantech-srf04.yaml: add pm feature
  iio: srf04: add power management feature

 .../bindings/iio/proximity/devantech-srf04.yaml    |  16 ++++
 drivers/iio/proximity/srf04.c                      | 104 ++++++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

-- 
2.11.0
