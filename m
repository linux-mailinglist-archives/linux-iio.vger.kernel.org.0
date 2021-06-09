Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC5F3A092C
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 03:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhFIBfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 21:35:12 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39702 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbhFIBfH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:07 -0400
Received: by mail-pl1-f175.google.com with SMTP id v11so3203631ply.6;
        Tue, 08 Jun 2021 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SB7sEpjvZQOQtpvHPsP8l+Li1AdCcsSe3f9eehUgeNA=;
        b=bR7sbjaGx4kSXHi4iNwDpN5CAiQqp8YdU7IFjtl5Vw5TAcgxrA07MXYJgROuXCDpoe
         Bw87UnUVk8DS6pTXSkn/fGSCfoTWdMR5dih+6lvsSkApTiPDkrwMRGRmbaZi8BgGieFN
         /vyNAgp8yev1m0pO+f5EGQvcsauSZiW2UdYjIX8KGpStHOhAyhTPhL5qatkPX49y3Fto
         UY0qLv+oDJKFpO4PkdH5AvXEMHhOQCRk5TAdzmj65M6BPz72BYtRIKWUOeDeCbhzlKHC
         a7WyvJlKOjHrwFm4hu9GWqDvJ+LFzKIvqUnmP2IJ8rF8Ic0mogEeKeyPwKNsE3pRlLFb
         Oz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SB7sEpjvZQOQtpvHPsP8l+Li1AdCcsSe3f9eehUgeNA=;
        b=uJDVJrsYCX6M97Io0QWxtEiZpLn6KSKMuRANaxtPaCfOJl9GqR3CkjTf/Sak4kXfGN
         dgK7HpqnY2iWrLWbzBhC6csedLInhq8kffhM9sARblU4+IgMmRPKF9/lUoeDtMwI45SC
         5vRZxnsSLYHb2GLhf1MC8zb2x9kKk2eQ8juZ0NSC9M+TWWTzacxMzP4H5vzRkqT+kufI
         Xy7SmJktAETXoTF9feJtrbXEMoE0Vn0BjB37xX0uxSBTDICk1HTMl2lhXn2/zVmrW6xV
         4g35Q6JltJpLgMT2QYqAzXL8oYQ8meNXHMMINphTzQlh73PxGxb9QiG17jIx0NRZlnoh
         5MXg==
X-Gm-Message-State: AOAM531M1DD2NRNDyKvrXEwxT7rwubVA8r9G+bN/vV6SI0t4b92msYzB
        7EBmuQDQ5fngpiEEDJUEKkc=
X-Google-Smtp-Source: ABdhPJy41Fnn86plANS8oj54WBpfJPXMo+Hw7PQLX7SuavwXtUnl64XC0Gjbxq637YKKZvhYZOfqaw==
X-Received: by 2002:a17:902:b713:b029:fd:8738:63cb with SMTP id d19-20020a170902b713b02900fd873863cbmr2592038pls.28.1623202318988;
        Tue, 08 Jun 2021 18:31:58 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:31:58 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 02/33] docs: counter: Fix spelling
Date:   Wed,  9 Jun 2021 10:31:05 +0900
Message-Id: <880c2fd0e2e91b8962c9d388b37ba582d548db8e.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"Miscellaneous" is the correct spelling.

Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 Documentation/driver-api/generic-counter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/generic-counter.rst b/Documentation/driver-api/generic-counter.rst
index b02c52cd69d6..64fe7db080e5 100644
--- a/Documentation/driver-api/generic-counter.rst
+++ b/Documentation/driver-api/generic-counter.rst
@@ -307,7 +307,7 @@ Determining the type of extension to create is a matter of scope.
 
 * Device extensions are attributes that expose information/control
   non-specific to a particular Count or Signal. This is where you would
-  put your global features or other miscellanous functionality.
+  put your global features or other miscellaneous functionality.
 
   For example, if your device has an overtemp sensor, you can report the
   chip overheated via a device extension called "error_overtemp":
-- 
2.32.0

