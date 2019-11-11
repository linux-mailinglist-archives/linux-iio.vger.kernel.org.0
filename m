Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FADF77C8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 16:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKKPfg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 10:35:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38714 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfKKPff (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 10:35:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so8213560wro.5
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2019 07:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IqboxVSwo0zc15MKnl74vo/KbesEjxX4qRyDh6yzeR8=;
        b=pg9whhrvOfax5w5SAUTqdImvM5ttK/AoVzHUWrIe/jJbuGH9lwt51Qq56W3iUd0yiC
         GNr30ClZUItFDZevOI0tZkMbo4NrRO5/yAOOHkM/YhdKwe1/U9Q1K1jonJ0lOTAs1+Yp
         HxO/UKy28JOkUbBLtwig7o0jCWYsf5NccfGB8ujXnRZxq1a1QTX54e4oHBrkKg0ZOLJ8
         nWqRSm9vFlTR5sds0rkR9jx3uIESaQ9R3z7avJ4cvZUGMiHMGtQ0evdFToAsFOxvsui7
         QkFwgZM9hdmll32pttu9+hJQZ1s7XGV8bEJK5ucwlUpZMoHPmJekVUKA4vfOjhlfWUIW
         ympA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IqboxVSwo0zc15MKnl74vo/KbesEjxX4qRyDh6yzeR8=;
        b=EDqUmETXZY/l1utPT9O/y8362Z9fFJCMb/grt+ahXAYzHigyrv3GFoKaRwI8fmW6X1
         WntSnUno1Von9OP/i/J3AylUWQTIWkpRUKOJLMdK3g/GpeOeW2ObWGkS6b5CUZB5s6Wp
         R0ouBxdvaCh+05Hr0YYr71xG6QE5vZfc1JbtRww7db7PC/vdYHlkG+fU2X2ZkKTqCTXD
         3l5OS98FbQ1aszIvJXeL3FXEtQlmuWlSEsMGkMnSKdRI3JHMvXtGatq2t4e44A6dNPP5
         oSM46pH42JIbKphyLRJjGQ4SU+SLMSG5f/XbVmlJml0jiDaibe2jAMwzxfkjBG9YcnSv
         CD0w==
X-Gm-Message-State: APjAAAVFsRPR9K1JF7V6gnnj4lD883AzR20NwxSvC4i1LmSg6YgXLg0K
        CbZejs0YJQ48UIlshem/P8s=
X-Google-Smtp-Source: APXvYqzfS9YC8+J9qmHQBv5stklzcoKZDJtq0T3CWlVMyucHhFg9G7K9SQ4+HIsJfLpBQJiar+SAGw==
X-Received: by 2002:adf:9ec7:: with SMTP id b7mr21688962wrf.221.1573486533570;
        Mon, 11 Nov 2019 07:35:33 -0800 (PST)
Received: from NewMoon.iit.local ([90.147.180.254])
        by smtp.gmail.com with ESMTPSA id w81sm23965657wmg.5.2019.11.11.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 07:35:33 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Colin Ian King <colin.king@canonical.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Daniel Gomez <dagmcr@gmail.com>, linux-iio@vger.kernel.org
Subject: [v2 2/9] Documentation: ABI: document IIO in_temp_filter_notch_center_frequency file
Date:   Mon, 11 Nov 2019 16:35:10 +0100
Message-Id: <20191111153517.13862-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111153517.13862-1-andrea.merello@gmail.com>
References: <20190923121714.13672-1-andrea.merello@gmail.com>
 <20191111153517.13862-1-andrea.merello@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

max31856 IIO driver introduced a new attribute
"in_temp_filter_notch_center_frequency".
This patch adds it to the list of documented ABI for sysfs-bus-iio

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Cc: Matt Weber <matthew.weber@rockwellcollins.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index faaa2166d741..94f7eb675108 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1726,3 +1726,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		List of valid periods (in seconds) for which the light intensity
 		must be above the threshold level before interrupt is asserted.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_filter_notch_center_frequency
+KernelVersion:	5.5
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Center frequency in Hz for a notch filter. Used i.e. for line
+		noise suppression.
-- 
2.17.1

