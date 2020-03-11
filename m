Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0A181237
	for <lists+linux-iio@lfdr.de>; Wed, 11 Mar 2020 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgCKHn3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Mar 2020 03:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:48192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCKHn2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Mar 2020 03:43:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA2E9AE61;
        Wed, 11 Mar 2020 07:43:27 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 0/2] iio: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 08:43:23 +0100
Message-Id: <20200311074325.7922-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

a trivial patchset to replace snprintf() calls with the safer
scnprintf() calls for avoiding potential buffer overflows.


Takashi

===

Takashi Iwai (2):
  iio: core: Use scnprintf() for avoiding potential buffer overflow
  iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow

 drivers/iio/industrialio-core.c | 34 +++++++++++++++++-----------------
 drivers/iio/light/tsl2772.c     |  4 ++--
 2 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.16.4

