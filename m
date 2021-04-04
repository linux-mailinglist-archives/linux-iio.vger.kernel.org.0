Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9235360B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Apr 2021 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhDDAs7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhDDAs6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 20:48:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A18C0613E6
        for <linux-iio@vger.kernel.org>; Sat,  3 Apr 2021 17:48:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id c17so5929447pfn.6
        for <linux-iio@vger.kernel.org>; Sat, 03 Apr 2021 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n0vLUHcJY9qlxonB+ok0V07BefT216FHYQcrnvrVkVc=;
        b=FWePUfi+4Dssm/JWagrPqvzla2jqzv0UnAttloXU0vHaGcxy38ss5mqXPmJqaioL8o
         IXQLU4ijuO+TKEcr3QJWo12rkEn/7Zpt5xxk7g1dDoIEGC0IJQwq9JQwe72GDnZuepuI
         Id1HqGliv0xcKyUAJwFwr5BXGN/RaKhAd32hKZqOScCq+Ti6wyBiicmsmyJ27fkqXn4O
         hWU30HIAhLN4u894Dt3tWjEXA5E+gBzioxPwj/lCGklMfuA8o1VzxqBNS8ARuoVhthfR
         tCt1GKoVhfnXnnNEX62yc4UuuPy/63CDSJUzlPD37K75OF0/Y+pDnUj5hyxumdd87kcZ
         yoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n0vLUHcJY9qlxonB+ok0V07BefT216FHYQcrnvrVkVc=;
        b=lzNaPCFov+aeEKk80DZH9PZgV/qPegO4xy5mw+OIZ9zM7QPfGMfar0BlSrKk8YsopJ
         ZdrrEwJFprV2u56ruUmJeN9QyTl0LJYmBbYjyMr2mXBfvWXsP6nrlh4uKOPNS1eiMiHY
         O0BCkHrW8y4Io/mpMljMrtsobKjz30KwH4LBuu8oK7Q0hmfzoqDZghKAbi2Dr8QO2RTS
         k+wUUI+l2eyIfawybZicg0djSZzg52VsUUWodHR+65kQYZDNTXZYB+xovpRMDD2rUvhm
         +zvn/xS82fD9LPeBIXJRjKWhwbpoIuF57gqPLyf0a4KEszXJwHU90yjnPcIDvJj7G1vx
         6/ng==
X-Gm-Message-State: AOAM532UdXxFC1CK4I4QmGMsv7EdMwKynBPl+jBdczFggEJzMuXxZy5T
        TPhg+tZ5IPExZl2ZWWR5rDQddm8dIp1UAV8qFZ8=
X-Google-Smtp-Source: ABdhPJyBPR8syAtgCukc0TtEBdQrFkBGDOJFqAcVQZLSOZUyES+5n2WQYcC6LUKd7+0hM0hlMBM5+vpnY03YjyxImO4=
X-Received: by 2002:aa7:9f90:0:b029:204:99fa:3374 with SMTP id
 z16-20020aa79f900000b029020499fa3374mr17936558pfr.11.1617497334802; Sat, 03
 Apr 2021 17:48:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:1a12:0:0:0:0 with HTTP; Sat, 3 Apr 2021 17:48:54
 -0700 (PDT)
From:   Lillian Windrope <lillianwnwindrope@gmail.com>
Date:   Sun, 4 Apr 2021 01:48:54 +0100
Message-ID: <CAA4ebrfmPtm+hKrK+qDOS0cE7m4EShZBmo3AyenBC3TewXBUfQ@mail.gmail.com>
Subject: Hi,
To:     lillianwnwindrope <lillianwnwindrope@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SGVsbG8gZGVhciBob3cgYXJlIHlvdSB0b2RheT8gSSBob3BlIHlvdSBkaWQgcmVjZWl2ZSB0aGUg
bWVzc2FnZSBJDQpzZW50IHRvIHlvdSBMYXN0IHRpbWU/LiBJIGFtIHdhaXRpbmcuDQrQn9GA0LjQ
stC10YIg0LTQvtGA0L7Qs9Cw0Y8sINC60LDQuiDRgtGLINGB0LXQs9C+0LTQvdGPPyDQndCw0LTQ
tdGO0YHRjCwg0LLRiyDQv9C+0LvRg9GH0LjQu9C4INGB0L7QvtCx0YnQtdC90LjQtSwNCtC60L7R
gtC+0YDQvtC1INGPINC+0YLQv9GA0LDQstC40Lsg0LLQsNC8INCyINC/0YDQvtGI0LvRi9C5INGA
0LDQtz8g0K8g0L7QttC40LTQsNGOLg0K
