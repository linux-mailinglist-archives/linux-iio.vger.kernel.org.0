Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 999EDB2E88
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfIOF6r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 01:58:47 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34393 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfIOF6q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2019 01:58:46 -0400
Received: by mail-pg1-f170.google.com with SMTP id n9so17486253pgc.1;
        Sat, 14 Sep 2019 22:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=ImJxU2R0GJ4SvUPU3OFTOmBFH8Vpam8zm/yXtHC20IxUjwM0MLxEJfuiGwZWr7cCsc
         Ftp7v4GDahPsmeBzLJYSwcOppIQiN7/PE8/cpSzup8pN67YsbCZL95sD1Kz5DAiFlUS9
         TjwDC5vt4dhTHb/VidMUQM9ETR0cmvR9XuEcUJevtbtK10zHlMR4M7XM2jTfP0NyTx/+
         7UkUMS9jFCwCF0ynDF6o35WnVYaGoAYSijxQEbr7CtBrK2ynyikR85DPJIne828DffMB
         /duIRbIeVCg92r8hX/vV3RFnjEXuTOrWHcoVKz6aRM+kNhLkH0LpviTuZng+hgPqWQoF
         4rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=pmPjdQaD+404kOISXapF79E94siGSN++dcxrJEZZc+XWJpS7cx0a1ymn7WyTD3ciR1
         7Y2PniQrnBFfScrPRHupy1rK+/CIXIOXKITJ85V/3973oPVb+IbnmYutYx8xYLCc9Cst
         b+5B7TppBnWkC2+RcRcveTtCW9tBkqbofEhCeVnjCUB9pkmvKDkhp91w+zuNIfAjmfw7
         ukLocQ1pkGisvO+ffDjhuCwHpFM+RN20tM67EA+8r1aLKzovOMTU5CzqE35O/76sMAXA
         4mrxJH8drrbAgr24lROcKjvX5vkSIModTFDVt34TaQ/l6H7e8MwZpfdijtFZxmr/TbTf
         R5dQ==
X-Gm-Message-State: APjAAAVJ+eGDKYgyt+lJskkel30mgfNJg5O/0oWcIef0tcS953nvxSGq
        t3jNKaJuW+IDWw9OtM16glI=
X-Google-Smtp-Source: APXvYqzj5kSNmAivQcPNxvF+89CgdhtEibJZP+YyQc+exlQwth5wjcsgepb95Cx8nx+30MFqZOl6aA==
X-Received: by 2002:a63:6097:: with SMTP id u145mr51395010pgb.227.1568527124005;
        Sat, 14 Sep 2019 22:58:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c144:8b8a:e7a2:82ca:6689:77bb])
        by smtp.gmail.com with ESMTPSA id 22sm3696658pfj.139.2019.09.14.22.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 22:58:43 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RFC 3/4] docs: driver-api: generic-counter: Update Count and Signal data types
Date:   Sun, 15 Sep 2019 14:57:58 +0900
Message-Id: <20190915055759.408690-4-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190915055759.408690-1-vilhelm.gray@gmail.com>
References: <20190915055759.408690-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Count data is now always represented as an unsigned integer, while
Signal data is either SIGNAL_LOW or SIGNAL_HIGH.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 22 +++++++-------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 8382f01a53e3..161652fc1025 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -39,10 +39,7 @@ There are three core components to a counter:
 COUNT
 -----
 A Count represents the count data for a set of Signals. The Generic
-Counter interface provides the following available count data types:
-
-* COUNT_POSITION:
-  Unsigned integer value representing position.
+Counter interface represents the count data as an unsigned integer.
 
 A Count has a count function mode which represents the update behavior
 for the count data. The Generic Counter interface provides the following
@@ -93,19 +90,16 @@ SIGNAL
 A Signal represents a counter input data; this is the input data that is
 evaluated by the counter to determine the count data; e.g. a quadrature
 signal output line of a rotary encoder. Not all counter devices provide
-user access to the Signal data.
-
-The Generic Counter interface provides the following available signal
-data types for when the Signal data is available for user access:
+user access to the Signal data, so exposure is optional for drivers.
 
-* SIGNAL_LEVEL:
-  Signal line state level. The following states are possible:
+When the Signal data is available for user access, the Generic Counter
+interface provides the following available signal values:
 
-  - SIGNAL_LEVEL_LOW:
-    Signal line is in a low state.
+* SIGNAL_LOW:
+  Signal line is in a low state.
 
-  - SIGNAL_LEVEL_HIGH:
-    Signal line is in a high state.
+* SIGNAL_HIGH:
+  Signal line is in a high state.
 
 A Signal may be associated with one or more Counts.
 
-- 
2.23.0

