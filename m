Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E89245A57
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHQAvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 20:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgHQAvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 20:51:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6908C061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:50:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l2so13243964wrc.7
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 17:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTEkQANijUR64LKDOWIWQzZQ8ax9HXFhFBb/D2Ez4Ck=;
        b=Rpg/OGCC2ZJWcRXUfY2GMNP33pBZ8kqJUBHvh6i/sqbU697NzfurM+BGNFwK5V/Eh7
         Pl4oRhYV2t4ix+HsFLMtV41Df70zPZW9OidKTF8oKnL1MZ5zIXmkswvSpXnMhfAgGmi6
         d6Uujt6k6vBeiGjCpFN6clSJZNW2OACUb4ZFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTEkQANijUR64LKDOWIWQzZQ8ax9HXFhFBb/D2Ez4Ck=;
        b=JHvS2/s+UbFRrsDs3N0qnlsMuFKZxoOMk+IZhwUlFSo4NyXAzQMCSzNNcYGKrhBDIh
         39p+v8Z9kAfav3yTRGMsARwpOrKyYc/TRjpIoz7uHeQLMvy93fX0OEESspwQwSeZX3v9
         ahv4vFCarZaSTGDy9mzvBcwqR5PLexzqmBNOQERVGw4XO+dJdSmMe+n7D7ybk1X3hivf
         s5+J7qgPRy8Gb0VNux0gRVsYygP2DZsycY2NTCOO8trBzPX64qARZA6ea+vuNkOHS1rS
         ooBFcbi3elKMbZdOOfOnxYNoXEau9IknCWDOruib3VvbV8BYn7gF+jEQ/sOhkKQL3PsX
         /Lmg==
X-Gm-Message-State: AOAM530PJFriXB8zaMLSpxG/r9Au8DUHFEvJ9/QNEbiU7sG/hNpyLrmw
        6ZX+xPxSDR1y9uLZtOwXpPZJDkHspwQo5Md6
X-Google-Smtp-Source: ABdhPJxEyEbMiXUTVWtTEiwdef5BnbS75H7vwNSGeo4EmUu3Qk8tnpWibuknLM94nj4o4TJfh9YNcQ==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr12688783wrw.155.1597625458310;
        Sun, 16 Aug 2020 17:50:58 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id b139sm29892711wmd.19.2020.08.16.17.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 17:50:57 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/2] iio: chemical: atlas-ezo-sensor: add humidity sensor support
Date:   Mon, 17 Aug 2020 03:50:50 +0300
Message-Id: <20200817005052.11565-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changes from v1:
* fix channel type to correct IIO_HUMIDITYRELATIVE
* fix scaling value to take in accountt the floating point is removed

Matt Ranostay (2):
  dt-bindings: iio: chemical: add Atlas EZO Humidity module
    documentation
  iio: chemical: atlas-ezo-sensor: add humidity sensor support

 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 +
 drivers/iio/chemical/atlas-ezo-sensor.c       | 37 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.20.1

