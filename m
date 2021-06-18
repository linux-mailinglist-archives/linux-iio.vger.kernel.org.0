Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0D3ACB01
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jun 2021 14:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhFRMc6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Jun 2021 08:32:58 -0400
Received: from aposti.net ([89.234.176.197]:41084 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhFRMcY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Jun 2021 08:32:24 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/2] Add "extended_name" to label
Date:   Fri, 18 Jun 2021 13:30:03 +0100
Message-Id: <20210618123005.49867-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

This is the v3 of my patchset that sets the label attribute to the
"extended_name".

v3 only refactors the code of patch [2/2] to make it look a bit better.

Cheers,
-Paul

Paul Cercueil (2):
  iio: core: Forbid use of both labels and extended names
  iio: core: Support reading extended name as label

 drivers/iio/industrialio-core.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

-- 
2.30.2

