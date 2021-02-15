Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9431BEAF
	for <lists+linux-iio@lfdr.de>; Mon, 15 Feb 2021 17:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBOQQC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Feb 2021 11:16:02 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34070 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231953AbhBOQBd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2021 11:01:33 -0500
Received: from [185.56.157.72] (port=34080 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lBeyE-00GYMx-Ic; Mon, 15 Feb 2021 15:35:26 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-doc@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/5] docs: iio: misc fixes and improvements
Date:   Mon, 15 Feb 2021 15:35:06 +0100
Message-Id: <20210215143511.25471-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Here are a few minor fixes and improvements to the IIO documentation.

Luca Ceresoli (5):
  docs: iio: fix example formatting
  docs: iio: fix directory naming
  docs: iio: document the 'index' attribute too
  docs: iio: fix bullet list formatting
  docs: iio: mark "repeat" sysfs attribute as optional

 Documentation/driver-api/iio/buffers.rst | 15 ++++++++-------
 Documentation/iio/iio_configfs.rst       |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.30.0

