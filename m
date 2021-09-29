Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8341CE10
	for <lists+linux-iio@lfdr.de>; Wed, 29 Sep 2021 23:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbhI2V3J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Sep 2021 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346607AbhI2V3G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Sep 2021 17:29:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B8C061772
        for <linux-iio@vger.kernel.org>; Wed, 29 Sep 2021 14:27:24 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ez4-20020ad45904000000b0038277ac82beso9280723qvb.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Sep 2021 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=cNc6jGThnDjPI1ROaAIDOXBHBBn9Ts0TfXP/c2N4EQM=;
        b=nXw3HxSp5/gbJuY/9VKOMd5rZ8zWZg+1bd3t6obcZvqMyAjqEvuu/VsFXwfvFdDBXj
         4Y5mgz8TDfHMA2MFbUKUu7wOgepF8QOGz55Axa9zrO0m4gUfZPPPD/c1i7qcBY1yxPCE
         8m2BF6Ds1jIgEjTeM8DmxQ5kif+7bmMqD6PVbYxyELJRGMRMpZWFq7JBR4G3ay8K5xKD
         xBG/hW0nBEn6do2u0BObmIwuDDbHR8az7TWLkCuTa4R8THFGK79eX8+ILMyL/n8LSoQl
         6bCSvqYE1F3vVP+jP9p1wmpkYmajdeSdc7ioI+zAzxrDb5coKV9M3Hm/J2edqL63zdO5
         IBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=cNc6jGThnDjPI1ROaAIDOXBHBBn9Ts0TfXP/c2N4EQM=;
        b=KNtTwh74pt3CblOyIpGTyCuIXmJ71CUTDZgto6rluarmU+WAWP5RhTPNwZF09s/lJx
         Hl66fRFWu7/wSLv9BoVKmwWq6cfXeEe6+3nABSwHF1mi4ve8LWhMLNahWd/X///4YORf
         kHiVAMu4c745WdVpoYMQoyngQvvxhm1L0xVxshzWubAVA6l1DK6RFPd2Q/j4kDakMJeH
         YwhUAOM9+OElG7qSYJDAUtFKyp11Ox7YBn5FbQc2kYeqNQN5ihlpH8/+Wacu9ZsEy1aJ
         hKFaR+CvfA/e4gUSwDB9JUlvI4f60/adrcWa407rH5NkIRPiB/AxPulFTnwQ43sDVDDu
         7hNw==
X-Gm-Message-State: AOAM531lTpP4+nJzsW1huRIy+HKaoFk4yX5hCAhBYf3wCMncU5xlsgyF
        HnQFuWlondbGfquq+VStsNjvOaU2KNNoyLW+oirefQ==
X-Google-Smtp-Source: ABdhPJx7qZ1J1thbDsoanP0bIyXW9jDN+YJBHFsBhknKK0oqEnDw16L75o14KW5MsBNjdljYyD/29vAPPuj0wnNt+PjTgQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:a6c:: with SMTP id
 ef12mr578832qvb.2.1632950843457; Wed, 29 Sep 2021 14:27:23 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:10 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 2/5] iio/test-format: build kunit tests without structleak plugin
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The structleak plugin causes the stack frame size to grow immensely when
used with KUnit:

../drivers/iio/test/iio-test-format.c: In function =E2=80=98iio_test_iio_fo=
rmat_value_fixedpoint=E2=80=99:
../drivers/iio/test/iio-test-format.c:98:1: warning: the frame size of 2336=
 bytes is larger than 2048 bytes [-Wframe-larger-than=3D]

Turn it off in this file.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Changes since last revision:
 - None
---
 drivers/iio/test/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f1099b4953014..467519a2027e5 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -5,3 +5,4 @@
=20
 # Keep in alphabetical order
 obj-$(CONFIG_IIO_TEST_FORMAT) +=3D iio-test-format.o
+CFLAGS_iio-test-format.o +=3D $(DISABLE_STRUCTLEAK_PLUGIN)
--=20
2.33.0.685.g46640cef36-goog

