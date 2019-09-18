Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17FAB5E55
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfIRHx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 03:53:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbfIRHx2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 03:53:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so3538024pgj.2;
        Wed, 18 Sep 2019 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=AkDFryyhXfRKyYsBUK/KXoVhWOS+frVLcJhgIH2cxTS3whUyNT8x2qvtaNcSFWmZvy
         5gsAQmmAO/3Gxs67mdVJcyC02/Jvf+6VXiHN1VH1qkQPZiu5eREbG0BkyO6aH3fnqqHS
         Id0cQ2DVr5dAEeR/Opp7cYg5Hk3IJT+duEw8CaFbEvueqmUysPnSgyXqEBzwtDxdFUKk
         sOhzOeSdHbNP7Xofpfxt+xqLByjC70EJpD0/NNRYwXvoJaRvuu1GZNfd19BNVYwMoCLK
         ZjFBOEMIA1l0YlAKCVd4B84k/44VcCjkkAsjE4giIMyTrTw0Ar5hauGdOXV4YG3vfhMH
         ilzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=WuThpUp2IPx9om3cU2o/9sT9EH2tVQlS4N2/AygV04YY3iNRhbiR4zs6yZ2OQ87Sx3
         IaaU6/O3XqA9OjXDXOiXiALoWjFkHToIayTwu/Pw6uQ430Sw/iLhtuArGhFwqlJ4NKdU
         V6tSxI95Tm8s1vE+DaZF1fZ2Em2rorRVF78Grys8JwuqDeAa8ujTLsnAklwNGV28UjN6
         SEaj8xhpj2rnIPFtazyOdZFuj0DYpRYOKaB5NQl6f3hjL2Nvx1Gwy8rxyUZw8LSGVRi+
         x34URm3sTpzPKneuvRdsJ4amVB9+YOrzh4ydtTI7sbS25lgWNQvKIAxUBlcls0+FznBP
         nhyw==
X-Gm-Message-State: APjAAAWITcf9tI2O0gt6Mr+TGnJTQmUkhHD9vbfXOE4qJO00sNmqngZ4
        YuqZZvFZMmuKPaBTyvtVuY0=
X-Google-Smtp-Source: APXvYqzaZ48uQhaDCpAmPYWnFCbRwXOhnRpAWgBqtZsQrr7+jFYScd1DVyElD2iND+AbYLOOfNJGWQ==
X-Received: by 2002:a62:ab04:: with SMTP id p4mr2716826pff.227.1568793207344;
        Wed, 18 Sep 2019 00:53:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c147:d9df:f819:e399:825f:f2dc])
        by smtp.gmail.com with ESMTPSA id h8sm5580715pfo.64.2019.09.18.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:53:26 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 3/7] docs: driver-api: generic-counter: Update Count and Signal data types
Date:   Wed, 18 Sep 2019 16:52:44 +0900
Message-Id: <f7e5486216f4368e1e00a20842928a1f0f6a4135.1568792697.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568792697.git.vilhelm.gray@gmail.com>
References: <cover.1568792697.git.vilhelm.gray@gmail.com>
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

