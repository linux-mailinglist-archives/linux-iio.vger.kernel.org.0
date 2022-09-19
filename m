Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D965BD0D0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiISPYk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiISPYL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:24:11 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79813399DA
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:23:24 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s14so10179782ybe.7
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=fupBLyMV86uu6UJ1A/Y1eECIAK/ILxADgNzx8tZ7Bt3M66dJebaPWeMcxrcIskOQPP
         3e9GKM99X0t77AoAT1hhS5gY6UYZRWsVloffTGQIyQoLPCLEocMrbivX2BLWbxg5DE5U
         7aQHhehpGr+QH1v4XM4C73i0uhRahd9Bc2WCxws9l8O80YLm2rZj0FkoeEw0omn5+sMv
         ZgL/AorMjJPX+k32Jep6FCvO3rm1C7tLrEMTRRL1PU514X9EMv+fdY/ii9R7N7N6VU/l
         dPlCAYSebKkR7YoYgvnOG2QMVgGlUIkAhpH7+eYleJtnnav3idLZPCD+AC5pYKn5XKzs
         7bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=YRcgG/dSi93MVxyeOkWMwPj4EZMODC1w1KAty+td7iL3214fXoVzrQobsSyjL7dkPw
         8G7mxMEbmdl/hXf5cvTAAd4AVlFoh3FykUNiPciMeDCTWwH28AGJ+9D5Gj6A6JndaJkg
         C3y+PQJgNEWYQjoXpdAJJ1lrYErfq9gvmOjI1OEoVSjbzlDhda6yaV5kbCD5sYa3jMk6
         rEMrbXT9+p4SJg4epPg7oCuTUsvIdq0PE7/iYlPR1W0VrilWqimnayzjIGWJ85fZU9us
         bEHmroNKa9UmkPiczMi3mLbet/S61fm3kkfgA/wL4qt/m6PzjG0AdctK5NRW1C8k28x/
         4NYA==
X-Gm-Message-State: ACrzQf0OVnhMHC/qvT7YEcGAjOZl36qyyIWvWjzd4tGOsvwpU02EhAii
        9YVOlZ2UrTGL+tUH+xQamyQo4rgE7Rl+RwNTwmo=
X-Google-Smtp-Source: AMsMyM5vj4rrxAOlvI5el8XFRafTCplT5HegmgsgnI6XgnTMx+hrk4NqWw57n1pZqh9e/UXJf5FN4OGkWeyoW/AAPV0=
X-Received: by 2002:a25:6611:0:b0:67b:e0c2:3239 with SMTP id
 a17-20020a256611000000b0067be0c23239mr14344244ybc.18.1663601003327; Mon, 19
 Sep 2022 08:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:76d0:0:0:0:0 with HTTP; Mon, 19 Sep 2022 08:23:22
 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <engrmorganwalter@gmail.com>
Date:   Mon, 19 Sep 2022 15:23:22 +0000
Message-ID: <CAM5a-p96h-dtPYiCLeqmJfUzyyyJviFDUNfKtVu1e8MY59mCaw@mail.gmail.com>
Subject: Did you receive the email I sent for you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


