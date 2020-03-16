Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D3186B63
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 13:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgCPMto (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 08:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731081AbgCPMto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 08:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EF28ABDC;
        Mon, 16 Mar 2020 12:49:43 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] iio: Use scnprintf() for avoiding potential buffer overflow
Date:   Mon, 16 Mar 2020 13:49:39 +0100
Message-Id: <20200316124941.8010-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

here is a respin of the trivial patchset to replace snprintf() calls
with the safer scnprintf() calls for avoiding potential buffer
overflows.

v1->v2: Fix the snprintf() buffer limit argument in tsl2772
	Rephrase the changelog


Takashi

===

Takashi Iwai (2):
  iio: core: Use scnprintf() for avoiding potential buffer overflow
  iio: tsl2772: Use scnprintf() for avoiding potential buffer overflow

 drivers/iio/industrialio-core.c | 34 +++++++++++++++++-----------------
 drivers/iio/light/tsl2772.c     |  6 +++---
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.16.4

