Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C21440F1F9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Sep 2021 08:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhIQGMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Sep 2021 02:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245065AbhIQGMx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Sep 2021 02:12:53 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEA2C061766
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d2-20020a0caa02000000b003784ba308f1so87175084qvb.9
        for <linux-iio@vger.kernel.org>; Thu, 16 Sep 2021 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=UY3TinilJRju1u6lzAykebCAKMTWaSuBZvn8jYC8UK4+LbXvIlCflfwHlFEphBHs8B
         1iFMgEZGban4DYDF7Ng4Bxjo8NRN9zOf3LLvDcjhZho+zGb8eIYgXkYwA0Otb0f/FShE
         yCmK2uqakDDxdXMcri2Lg+CMzpqgtphiucDdAVEWrO4iTlv4H6bq8Gawab6VO22To9bF
         X7RxLGWNSjvgLN+qQRj6LibXm4BaLGhu5Xy+N2dBaNZPk7IY2MX6VGtuGBV+XMHGYz17
         gK2smKuDIdXkivtrGOnp7UxDzkVWma4nv+Xs6OV5VYWRjcuzPSQps0HL5bUHRRb0Qx+d
         Iq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=I4FOT8yOHsLhfAzdZiAF0l/kcO/QKiXi6j8WbW9LXJI=;
        b=3EV0oyC0uuzkeTIuh3Au0LXXbZoRcgfJboZF9W5MxkxKku77v2Uj+fd9OsUcZ7Xi3J
         bPA/kjJC6jq7tlAyVG8evqDc1CjomU3AK8ajZfJ0pSqa+XryXgCsuVcOVx1ZnHzUFglZ
         Ofaq1bLlE9ZCUOWt4KvFXrC3xzf4B+3exNWXFsM24ZIVQmUXKFa6mY0UvnEoiDxpaDgF
         +nW4JaN41ZYNETLO0AraZvEDfyo5lP/l/j0Z2voJEvi+lMZqSmSDsnRT+PsWB7rltj42
         EOgrvjd4mEpXn7TdCdV4IuIk0wDei1NM848roqc4F7RjGVkKF63rIU6WqegyUUfeg3Jr
         9I2w==
X-Gm-Message-State: AOAM530BLqefZwDvU8N3KxfVlLLT6aboOrKHCiGqo2lMpWgKnqsFvWGx
        o28DA/gXu/t3a4/xxf6vP3cJkdoni0IXzaK+KqPpCg==
X-Google-Smtp-Source: ABdhPJxQU9dA2VoByCENV7Js4YP5bqWeXxiNL61cyojxtkYNrLzgmDJAwC0DC/PduGlki5LgIsdKe1pz5QUxEe86UMUTvA==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:4845:43ba:3ff5:2de1])
 (user=brendanhiggins job=sendgmr) by 2002:a25:6d43:: with SMTP id
 i64mr11100758ybc.252.1631859090133; Thu, 16 Sep 2021 23:11:30 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:11:00 -0700
In-Reply-To: <20210917061104.2680133-1-brendanhiggins@google.com>
Message-Id: <20210917061104.2680133-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210917061104.2680133-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v1 2/6] iio/test-format: build kunit tests without structleak plugin
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
        Brendan Higgins <brendanhiggins@google.com>
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

Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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
2.33.0.464.g1972c5931b-goog

