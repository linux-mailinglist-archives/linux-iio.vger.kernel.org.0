Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14EECD911
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfJFUDd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 16:03:33 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:46450 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfJFUDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Oct 2019 16:03:33 -0400
Received: by mail-yw1-f45.google.com with SMTP id h10so1337518ywm.13;
        Sun, 06 Oct 2019 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oi1lDkMlTFONnp6bwWaGnqUvaiX5vepqhjmjsnY4BQc=;
        b=LBbx5c6oe/DCoJegdyvkhilRsrfMIqU1E1Q/6QHocTi1xd4DvJDg8qxjOgu91Ccd7X
         IpFtmWi/mtWV2ozmStU60+ocRReTEq6hwuhohf1gODtt8k9IYFNYGW+EkxMq8dvk02bv
         y8SdobV4fvu1QSDn/FYcCnGV0FvMFdjT/oN4UPm2zEVen9phKHif2qtoHAVTkOc9kW1v
         ibGVflyXht7pQOoCLpAFbfS7E63yZWS5KYtCiT56ma9BCRdR1zNsDozbirkm4Fi+f6N+
         F28mr8vQ/dEEy/SobhSt9P8nzh5aRzlM6XQfx88QE0A7MLf1pga0IqiOyPu6KQOTmlwN
         GkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oi1lDkMlTFONnp6bwWaGnqUvaiX5vepqhjmjsnY4BQc=;
        b=sUi4bqIlGfQPJpe70SRSyn8sZYn0pL0+1hKmLcFEO2h+ZQQFS5yA2HicwAZxOK8rnA
         vssNr/kgAgbf0FNAEbtLEsVUY/cxpFfB6VLv9DeDaZN2gMLImNM2Vkc3uU/KOreh6Lss
         kVsJjzToDwNGc9NSjnqEUuQjOLS81DqFl74HjL5ZZkei68+I3qTtFB74Z+NwlVWhLyKD
         wXoJquCKKLlLLQ3cyibKJoKqzuG8WOd0gNKUF5xZ1IqFFMuAtQ4OIMo/UlqRwBlMW6sC
         qS35WUc3iXSQvvERsGOpfw9X3u9GLSP5yr7S/8JqadNuDHg6z6RrULHj5WqIQN8DPF8H
         CLkQ==
X-Gm-Message-State: APjAAAXN5RTOVpunTh1elQ1ZadQFu3FZHVKVKUMwWSyU42IJx+G4BpPD
        2S3R4qRAVEsvteLfdyxxIcQ=
X-Google-Smtp-Source: APXvYqyW8RVmQI6J41bkpIKVj8Zd5IiblHuEB0TjHzh3r1P2DVY6tYSPzDgwRTyxamsLWg/zD4eouA==
X-Received: by 2002:a81:7a02:: with SMTP id v2mr17797467ywc.398.1570392212146;
        Sun, 06 Oct 2019 13:03:32 -0700 (PDT)
Received: from localhost.localdomain (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id x16sm3765266ywx.103.2019.10.06.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 13:03:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        david@lechnology.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 2/3] docs: driver-api: generic-counter: Update Count and Signal data types
Date:   Sun,  6 Oct 2019 16:03:10 -0400
Message-Id: <927b67f2c645faab1182229625e93913c2a267ef.1570391994.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570391994.git.vilhelm.gray@gmail.com>
References: <cover.1570391994.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Count data is now always represented as an unsigned integer, while
Signal data is either SIGNAL_LOW or SIGNAL_HIGH. In addition,
clarification changes and additions are made to better explain the
theory of the Generic Counter interface and its use.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 162 +++++++++++--------
 1 file changed, 92 insertions(+), 70 deletions(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index 8382f01a53e3..e622f8f6e56a 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -7,7 +7,7 @@ Generic Counter Interface
 Introduction
 ============
 
-Counter devices are prevalent within a diverse spectrum of industries.
+Counter devices are prevalent among a diverse spectrum of industries.
 The ubiquitous presence of these devices necessitates a common interface
 and standard of interaction and exposure. This driver API attempts to
 resolve the issue of duplicate code found among existing counter device
@@ -26,23 +26,72 @@ the Generic Counter interface.
 
 There are three core components to a counter:
 
-* Count:
-  Count data for a set of Signals.
-
 * Signal:
-  Input data that is evaluated by the counter to determine the count
-  data.
+  Stream of data to be evaluated by the counter.
 
 * Synapse:
-  The association of a Signal with a respective Count.
+  Association of a Signal, and evaluation trigger, with a Count.
+
+* Count:
+  Accumulation of the effects of connected Synapses.
+
+SIGNAL
+------
+A Signal represents a stream of data. This is the input data that is
+evaluated by the counter to determine the count data; e.g. a quadrature
+signal output line of a rotary encoder. Not all counter devices provide
+user access to the Signal data, so exposure is optional for drivers.
+
+When the Signal data is available for user access, the Generic Counter
+interface provides the following available signal values:
+
+* SIGNAL_LOW:
+  Signal line is in a low state.
+
+* SIGNAL_HIGH:
+  Signal line is in a high state.
+
+A Signal may be associated with one or more Counts.
+
+SYNAPSE
+-------
+A Synapse represents the association of a Signal with a Count. Signal
+data affects respective Count data, and the Synapse represents this
+relationship.
+
+The Synapse action mode specifies the Signal data condition that
+triggers the respective Count's count function evaluation to update the
+count data. The Generic Counter interface provides the following
+available action modes:
+
+* None:
+  Signal does not trigger the count function. In Pulse-Direction count
+  function mode, this Signal is evaluated as Direction.
+
+* Rising Edge:
+  Low state transitions to high state.
+
+* Falling Edge:
+  High state transitions to low state.
+
+* Both Edges:
+  Any state transition.
+
+A counter is defined as a set of input signals associated with count
+data that are generated by the evaluation of the state of the associated
+input signals as defined by the respective count functions. Within the
+context of the Generic Counter interface, a counter consists of Counts
+each associated with a set of Signals, whose respective Synapse
+instances represent the count function update conditions for the
+associated Counts.
+
+A Synapse associates one Signal with one Count.
 
 COUNT
 -----
-A Count represents the count data for a set of Signals. The Generic
-Counter interface provides the following available count data types:
-
-* COUNT_POSITION:
-  Unsigned integer value representing position.
+A Count represents the accumulation of the effects of connected
+Synapses; i.e. the count data for a set of Signals. The Generic
+Counter interface represents the count data as a natural number.
 
 A Count has a count function mode which represents the update behavior
 for the count data. The Generic Counter interface provides the following
@@ -86,60 +135,7 @@ available count function modes:
     Any state transition on either quadrature pair signals updates the
     respective count. Quadrature encoding determines the direction.
 
-A Count has a set of one or more associated Signals.
-
-SIGNAL
-------
-A Signal represents a counter input data; this is the input data that is
-evaluated by the counter to determine the count data; e.g. a quadrature
-signal output line of a rotary encoder. Not all counter devices provide
-user access to the Signal data.
-
-The Generic Counter interface provides the following available signal
-data types for when the Signal data is available for user access:
-
-* SIGNAL_LEVEL:
-  Signal line state level. The following states are possible:
-
-  - SIGNAL_LEVEL_LOW:
-    Signal line is in a low state.
-
-  - SIGNAL_LEVEL_HIGH:
-    Signal line is in a high state.
-
-A Signal may be associated with one or more Counts.
-
-SYNAPSE
--------
-A Synapse represents the association of a Signal with a respective
-Count. Signal data affects respective Count data, and the Synapse
-represents this relationship.
-
-The Synapse action mode specifies the Signal data condition which
-triggers the respective Count's count function evaluation to update the
-count data. The Generic Counter interface provides the following
-available action modes:
-
-* None:
-  Signal does not trigger the count function. In Pulse-Direction count
-  function mode, this Signal is evaluated as Direction.
-
-* Rising Edge:
-  Low state transitions to high state.
-
-* Falling Edge:
-  High state transitions to low state.
-
-* Both Edges:
-  Any state transition.
-
-A counter is defined as a set of input signals associated with count
-data that are generated by the evaluation of the state of the associated
-input signals as defined by the respective count functions. Within the
-context of the Generic Counter interface, a counter consists of Counts
-each associated with a set of Signals, whose respective Synapse
-instances represent the count function update conditions for the
-associated Counts.
+A Count has a set of one or more associated Synapses.
 
 Paradigm
 ========
@@ -286,10 +282,36 @@ if device memory-managed registration is desired.
 Extension sysfs attributes can be created for auxiliary functionality
 and data by passing in defined counter_device_ext, counter_count_ext,
 and counter_signal_ext structures. In these cases, the
-counter_device_ext structure is used for global configuration of the
-respective Counter device, while the counter_count_ext and
-counter_signal_ext structures allow for auxiliary exposure and
-configuration of a specific Count or Signal respectively.
+counter_device_ext structure is used for global/miscellaneous exposure
+and configuration of the respective Counter device, while the
+counter_count_ext and counter_signal_ext structures allow for auxiliary
+exposure and configuration of a specific Count or Signal respectively.
+
+Determining the type of extension to create is a matter of scope.
+
+* Signal extensions are attributes that expose information/control
+  specific to a Signal. These types of attributes will exist under a
+  Signal's directory in sysfs.
+
+  For example, if you have an invert feature for a Signal, you can have
+  a Signal extension called "invert" that toggles that feature:
+  /sys/bus/counter/devices/counterX/signalY/invert
+
+* Count extensions are attributes that expose information/control
+  specific to a Count. These type of attributes will exist under a
+  Count's directory in sysfs.
+
+  For example, if you want to pause/unpause a Count from updating, you
+  can have a Count extension called "enable" that toggles such:
+  /sys/bus/counter/devices/counterX/countY/enable
+
+* Device extensions are attributes that expose information/control
+  non-specific to a particular Count or Signal. This is where you would
+  put your global features or other miscellanous functionality.
+
+  For example, if your device has an overtemp sensor, you can report the
+  chip overheated via a device extension called "error_overtemp":
+  /sys/bus/counter/devices/counterX/error_overtemp
 
 Architecture
 ============
-- 
2.23.0

