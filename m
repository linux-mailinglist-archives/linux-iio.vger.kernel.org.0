Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C71B65FE
	for <lists+linux-iio@lfdr.de>; Wed, 18 Sep 2019 16:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfIROXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Sep 2019 10:23:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41190 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbfIROXg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Sep 2019 10:23:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so53138pfh.8;
        Wed, 18 Sep 2019 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=AQUtfExt8PphIK/V+c+mEJ3tgaUEISxw78DBCeSXeyLH9gYToCX1fyDRsFiqifcLuN
         c5domyKtQbNk8UW32C/o8pZxeVKctq+eYM2nl/a+mrfcyhODXnb1TWcvL3vFe3MDygUK
         358nsEwOyj4l+QNqq6/0BFrGmo5RY6rTAIZqbnkTVAqAnMc+ybt1H0p7QnhLAYo0iSGa
         W/AAiFLjZJoyfi3SME//ZCANuAHVX9bV2/CFWUIAQL4r8biRaX9RplWV0+THsCypl3Gp
         G+ZgOwie51YPSdJZmnm4/9gLYzpCIxn8HXzoM2hzP3BYjAceYcayoq/G0oXGgCoTG/i3
         u3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0YlaBg0eWRFmg01LcYcEakBboU2udItKz/WvLmsstE=;
        b=dS0VCQmttJ0uhvcCDU2xIrMT4XxM7x8ymI0HivUVIywEh/ocoJusZYWlAtIHChIi/P
         rKnGzxsZYzJ5PzLgEVWN+ZRY3SZC2Om53lorO5KJsXj0GWuwBHSHytK94ntZrM52kZcW
         dk+gJ9iWBfls1HNoMI/NdqKHnTyE2qjtKFmUSWRE73oXvyJIW+FQj/j8aXr+/fX+JkQ9
         F1e8NLFUvOXtjy099Vj0e+02WjqhMM/LuGbfaNyuOHsh74etZaX2YowPvrE7QnqYdgct
         A6ZbY+BlI+M7jmrjg0YnHHAtF67dV29rfCgbs0/c7TrNNCn1Svd8asZAkfgF2XzrFrkc
         EWrQ==
X-Gm-Message-State: APjAAAVS7Ts1oksG9FgpUsZ9DOVyvjzjjDCZQzNQ81moVbBlwF8FDmeh
        9qAHeOZq56bEmvbIG+91LaE=
X-Google-Smtp-Source: APXvYqwraF/YHqWdOvbISaW0toiHH71DUpkNZY1Cp7PbrQONBy+X5ThJP7vWM980IKlnropOI/g2qw==
X-Received: by 2002:a17:90a:c8a:: with SMTP id v10mr3943216pja.6.1568816615452;
        Wed, 18 Sep 2019 07:23:35 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c145:8e3a:1c91:3b66:30:c335])
        by smtp.gmail.com with ESMTPSA id d5sm10996675pfa.180.2019.09.18.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 07:23:34 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 2/2] docs: driver-api: generic-counter: Update Count and Signal data types
Date:   Wed, 18 Sep 2019 23:22:46 +0900
Message-Id: <e7517c4062cfa186f90dc9e16765bd0745068c0b.1568816248.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568816248.git.vilhelm.gray@gmail.com>
References: <cover.1568816248.git.vilhelm.gray@gmail.com>
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

