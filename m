Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0918A3AA097
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbhFPQAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 12:00:00 -0400
Received: from aposti.net ([89.234.176.197]:51006 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235183AbhFPP7b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 11:59:31 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/2] Add "extended_name" to label
Date:   Wed, 16 Jun 2021 16:57:04 +0100
Message-Id: <20210616155706.17444-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Here's the v2 of my previous patchset which added an "extended_name"
attribute.

Following the discussion on the v1, here's a set of two patches that
1. make sure we will never have channels with both labels and extended
   names,
2. make the extended name available to userspace as the channel's label.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Forbid use of both labels and extended names
  iio: core: Support reading extended name as label

 drivers/iio/industrialio-core.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

-- 
2.30.2

