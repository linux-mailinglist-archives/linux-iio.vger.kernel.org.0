Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1B64C9C2
	for <lists+linux-iio@lfdr.de>; Wed, 14 Dec 2022 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiLNNJH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Dec 2022 08:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiLNNJA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2022 08:09:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1635DE93
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 05:08:57 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 1so10365782lfz.4
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2022 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PedTboiFtvABud73ZD3U4hUNQIS0oeFWRBzeT0lU6t8=;
        b=KxNdjgQBBMefpFtO1FEOgrggLT8o+qZDfroZw26F0Wv0Nxpn0xu9xNsdKWRy3Tw8bn
         3uBMa/7AEqqjC/PMfuoqKWvVC5DOyip+tZtU9MJs5nl4fxwWT0YGm7OMC2MTSporlAgR
         uNGX8CUL49SHU8ddhDx3ElaxyXbolwzGfnMMmldXQp7emry9hbmp/KuPRA9F0MjIiQ2Z
         dSkIzopkbTiIVz4K7tlH0kGmyqbalMk02wZGbh3IlqwfrbR9rDnnd2pXSwUjeh/EtUjQ
         +M9S8N5KIWGbu1MopCKi+Y+KYZHT6cDTVnC+/G9IM5GpspwyQ30hFg/66iuFDlheHyUP
         TBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PedTboiFtvABud73ZD3U4hUNQIS0oeFWRBzeT0lU6t8=;
        b=xM0/qVrrx2aqGSbnrWTOUbQ9L9mzYsTlE7aq5G0fL3cNzu3VC/+7id+luQjooDWnol
         4hMLqeCUFwG2Myrbi4ythzssKC+JspM4EpjJW1FDDPV/gx7jPJcJperpjxlOJVbKt0mV
         EhbknFX7Lbl11QC7GgRlmU4Mb4KEuM6dt1lAtDZiJlk9tdZhACwofiHtruIphkjdd89y
         69gTDsn6Zd6TG6K+ndAmtL5RlTyOL3B9FigxX9cPsetCeIcIQxpE/wLNYeDBT4Cy2lVM
         5GDTBRecpt+l0FWmZsGYcBTx5daoYA/e53DSY2P22d6qICVflBoTw/UuFdErcpAgODCA
         +JrA==
X-Gm-Message-State: ANoB5pksRJOcpGBsdzN15uHUv3CtXhsO9+Wz/RUuROABgYKBTmelHp9s
        ntgHHoyLbIQfNq9zJs3dFXWCGSfpBwWWwE2wPjQ=
X-Google-Smtp-Source: AA0mqf7aqfGeGqDDOw+H/ntC+nwy73TSEmbwetV0rbXvZf5FsiA5pNXvyDL3eCkdfjVsC5t7TR7v31XEbh/l8BEoqhU=
X-Received: by 2002:ac2:4563:0:b0:4b5:afc6:1f74 with SMTP id
 k3-20020ac24563000000b004b5afc61f74mr1466029lfm.577.1671023336032; Wed, 14
 Dec 2022 05:08:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:1597:0:0:0:0 with HTTP; Wed, 14 Dec 2022 05:08:55
 -0800 (PST)
Reply-To: a2udu@yahoo.com
From:   "." <urri8344@gmail.com>
Date:   Wed, 14 Dec 2022 14:08:55 +0100
Message-ID: <CAKzm1Z4NTZFpkD10SG0cQ6+WLXF0_7ELoUXkkr9FewwDX5Z7SA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello

The money is ready to be transferred, kindly acknowledge your interest.
