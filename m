Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99CCD351
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 18:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfJFQDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 12:03:33 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40549 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfJFQDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 12:03:32 -0400
Received: by mail-yb1-f196.google.com with SMTP id s7so235242ybq.7;
        Sun, 06 Oct 2019 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=fyQ5xERCIVVSDumVC4ubV58r5dQvmSwwgM1gDnffp4c+23b97gjExIR2w5eKv7/8Jq
         ziZYQoR+ekNbyGmg5MyCdRKQCpjPl96Gg05vwaXu+bKwftDmAqbbBSH5E6QwSe5Ye+LQ
         xBUefkUGCXsIWAzl+r81TYehHx4jhYKp4zVdIT8iewLeyrco31I++sQZr0GkvC3qWrAI
         ySzHJ9fVZA81+D7Pk/jT9oRRn9rbqPtPhS1BPMSDfCtq7jRYvKthUyl4YoB3plYqlI9i
         4S/8SyDDMH2Wqfnrbl6M9RacL1dX7HAom4on1ZHwAGQZJQp1mHNTFfq/qMP0zFcmFZqo
         4HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=h2AqfsgfBUduBbMXjwZUowQ3JGqBftwq/eNBjkrrKGQFB1wha9OA6GF53dfWCSO3d+
         ocKs1IWIb9k28/DsCZVtenLL6H7b0ichuXKmz8OQDOF2kVSh297Nt1JYnx5E+qk/YZ6I
         OiY/1KN1e4/F1FeY6hQFa4VNL1deB40At1Jd6Vb1Ss/Qj8Jkhqo6TMPHTNn7eSy4kjOe
         aMom5t2bOnC9PPprZ1vJEuKdebiHW1Y+QVOk8jnqYpoDfJhbU7f6J7JVLEqZ3n05UNv2
         62ECRyrsGLOHAxdES//c+lMpFrrNDHt8AfZBkZTPm+alXbHxoEHxevyiLoNBMd8snNS+
         8eCA==
X-Gm-Message-State: APjAAAXnnZzAIHViLdxPfq/dLuxyd7IRUwoezMkZn4ZimylR+rbJbMLz
        66jebKUPWUZJ3KYthUai5AY=
X-Google-Smtp-Source: APXvYqxNW/YNL3A3scV1Qc1+vAzbrjym3yfhoINYZ8xNzXVB83HFsdfnpe2UcuggrPJqmHwKu7egzA==
X-Received: by 2002:a25:ce08:: with SMTP id x8mr8866430ybe.177.1570377811262;
        Sun, 06 Oct 2019 09:03:31 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id y129sm3341816ywy.41.2019.10.06.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 09:03:30 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 2/2] docs: driver-api: generic-counter: Update Count and Signal data types
Date:   Sun,  6 Oct 2019 12:03:11 -0400
Message-Id: <75a9ca9837f4d66cb4912cfa535176e27f7c219a.1570377521.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570377521.git.vilhelm.gray@gmail.com>
References: <cover.1570377521.git.vilhelm.gray@gmail.com>
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

