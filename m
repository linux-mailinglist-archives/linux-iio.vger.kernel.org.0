Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441FE2B8E78
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgKSJNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 04:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgKSJNy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Nov 2020 04:13:54 -0500
Received: from lore-desk.redhat.com (unknown [151.66.8.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E5D2075A;
        Thu, 19 Nov 2020 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605777233;
        bh=nS3pRh/CX6pRxkXZXx/j8Lj3d35cxQwKTO5KCyD9wGM=;
        h=From:To:Cc:Subject:Date:From;
        b=hV8NZn5qxIOGa/1/hzYBz3ZFlTII6dEVKozun2GuVdpsQcpZpiu3jPvjDW4Uu6tUp
         HasIgvspXnbZZ98bZIckgDIAeeQFJxjc4pY4GgWNj/sXhTfh2uELnzVMru0GC5kCUx
         +0arKw+Bsoiqr1wrG69ky5y98LUWw0pz0xKjiOWI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/2] hts221: add vdd power regulator
Date:   Thu, 19 Nov 2020 10:13:33 +0100
Message-Id: <cover.1605777052.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce support to control VDD power line available on hts221 devices

Lorenzo Bianconi (2):
  iio: humidity: hts221: add vdd voltage regulator
  dt-bindings: iio: humidity: hts221: introduce vdd regulator bindings

 .../bindings/iio/humidity/st,hts221.yaml      |  3 ++
 drivers/iio/humidity/hts221.h                 |  2 +
 drivers/iio/humidity/hts221_core.c            | 39 +++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
2.26.2

