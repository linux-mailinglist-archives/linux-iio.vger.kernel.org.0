Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04E97DDED4
	for <lists+linux-iio@lfdr.de>; Wed,  1 Nov 2023 10:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjKAJ6i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Nov 2023 05:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKAJ6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Nov 2023 05:58:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFE3103
        for <linux-iio@vger.kernel.org>; Wed,  1 Nov 2023 02:58:29 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so11251437a12.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Nov 2023 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.uny.ac.id; s=google; t=1698832708; x=1699437508; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pfk9cqqe8i+/+fOTb1lE6xWp6G+mo2TybLpvLQN5I=;
        b=H3DVfF+wEgV1lWvS0EmtO8f5xlMAxXU8vU6p7DsVE1TjR7nsfBm/pWX20uAVHM7LdH
         ijfDzSM+tUJF6na/SB7izFmtxQsIzRgcv893PTxEfzajTd0OEd/X76Wge6uVrieyodYx
         4MrX2IgHKAakArMrtpmnrBqPfYQNkGhjkSGqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698832708; x=1699437508;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3pfk9cqqe8i+/+fOTb1lE6xWp6G+mo2TybLpvLQN5I=;
        b=d8gjSzeH2HWchN+Iq1fnRVr262Ua3GX81azZqEo1l5886fQJGIdWgrg+bYIGgB8/CF
         QLQUPzMLx+qEam0Q513h1KGy6mcI5c+p3jWhiB/o1Bxh4N1KXNiUFdo/NN5hG+z/n+6C
         deSbZymlO8QlQA3QNTXM5KOIa7VqNE3MxdoyDYnhTBrys3KmHCR7vcSmdyIbnV+KkYKL
         I/lR+RQuym9fmW4g6zz4KjN9br/fA/IlLNZZK6bzHN+wQA/VabJSGCkM6jt7iS9Kpcir
         5cl4BvEI7vpk+q982VnW9dCaDddlNzc2Y6ZLE+X5R4/6rdrczRGJ1HoOwSUQHW+/HHmN
         VIeA==
X-Gm-Message-State: AOJu0Yzc8EjXFTDNNdQPk6cenrLmZGnPi4/HEeopi+cOJtaKaoLaBiIa
        1Q/UEhC7KcbFrLgfwp/7rcnF7MeTdiEW22rLChhEa1HlvIfXuN61DfnOlP3MtesQyi7mGN1mhCP
        qf/evljsGGj7ImorTIQ7VspYiVg/kIg==
X-Google-Smtp-Source: AGHT+IGQktC2sEKth5oRBZPP6Z1EhwkaAU+R6GmqPxY+ksuSnwAzmNrgIMKI8l+p6kYO5vwANxomVoaDLf1ydNcZEPE=
X-Received: by 2002:a17:907:3fa0:b0:9bf:d65d:dc0f with SMTP id
 hr32-20020a1709073fa000b009bfd65ddc0fmr1668531ejc.4.1698832707889; Wed, 01
 Nov 2023 02:58:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:ee84:b0:9d1:3fc8:cea7 with HTTP; Wed, 1 Nov 2023
 02:58:27 -0700 (PDT)
Reply-To: mrslovethkonnia5@gmail.com
From:   PM <evitanadiadamayanti.2020@student.uny.ac.id>
Date:   Wed, 1 Nov 2023 09:58:27 +0000
Message-ID: <CAFhWKU2c-3mdiF2LU-ZkgQ8X+be2rXq662KOPvvfWK6yc=3eFg@mail.gmail.com>
Subject: Querido
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ol=C3=A1 querido,

Como voc=C3=AA est=C3=A1 hoje?

Te mandei um e-mail ontem, voc=C3=AA recebeu?

Sra.Loveth Konnia

....................................

Hello Dear,

How are you doing today?

I sent you an email yesterday, did you receive it?

Mrs.Loveth Konnia

--=20



-------------------------------------------Untuk mendukung =E2=80=9CGerakan=
 UNY=20
Hijau=E2=80=9D, disarankan tidak mencetak email ini dan lampirannya.
(To support=20
the =E2=80=9CGreen UNY movement=E2=80=9D, it is recommended not to print th=
e contents of=20
this email and its attachments)
Universitas Negeri Yogyakarta
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
www.uny.ac.id <http://www.uny.ac.id>
-------------------------------------------

