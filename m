Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D892656
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 16:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbfHSORY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 10:17:24 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42256 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfHSORX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2019 10:17:23 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 6869525AF0E;
        Tue, 20 Aug 2019 00:17:21 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 512E79406ED; Mon, 19 Aug 2019 16:17:19 +0200 (CEST)
From:   Simon Horman <horms+renesas@verge.net.au>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2] dt-bindings: iio: light: isl29501: Rename bindings documentation file
Date:   Mon, 19 Aug 2019 16:17:08 +0200
Message-Id: <20190819141708.20456-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rename the bindings documentation file for Renesas ISL29501 Time-of-flight
sensor from isl29501.txt to renesas,isl29501.txt.

This is part of an ongoing effort to name bindings documentation files for
Renesas IP blocks consistently, in line with the compat strings they
document.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on v5.3-rc1

v2
* Drop spurious top-level Makefile hunk
---
 .../devicetree/bindings/iio/light/{isl29501.txt => renesas,isl29501.txt}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/iio/light/{isl29501.txt => renesas,isl29501.txt} (100%)

diff --git a/Documentation/devicetree/bindings/iio/light/isl29501.txt b/Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/light/isl29501.txt
rename to Documentation/devicetree/bindings/iio/light/renesas,isl29501.txt
-- 
2.11.0

