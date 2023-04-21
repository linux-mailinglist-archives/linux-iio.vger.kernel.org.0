Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C56EA61B
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjDUInF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjDUImw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:42:52 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD417D81
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:42:47 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54f9d6eccf3so15931587b3.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066567; x=1684658567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUq9DdozR50+s0bIzneFBHO+vDWvZZ8xarrXjkdfie8=;
        b=q60qS2knWMIPPYeEAQPryZoGfmvRafE+cukUeHxeOxrV8fZK+cRsn9kEBnP2j8L6V7
         sCS4hC+nj/UxEjgTu1wbM1HgiGZB/wXrmymwW9d+C+Mbhfen/UKFqzoY8PQxfJ9GiM9a
         q4OatBMRJwZ4KiAljmtZ9m6XQZ4TSQhehLcqHEu7ZV4uiXs8f9KylJINQJTJyqdfhvle
         gEOmkw0qXfGwZOtfEvOReg0HazZQ5d9Rs9EjepuptZ0zyx7Lh3VYL/Yvu1n6fTAlWh5a
         vAFbQ/0DBG1AE0lyDQM1fymISF5SeHqx/lgX9ATYa2exg8o1LKbnMxTr2M6imXuLgQIk
         5xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066567; x=1684658567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUq9DdozR50+s0bIzneFBHO+vDWvZZ8xarrXjkdfie8=;
        b=W0pyBDa8JfIEI701bPVbbBK4WtNHK0W9/DYQPdklMxukogzcM+MNgbh84tDHZJBBMa
         9WgsmP8659YujdPO9QStswigmm7jjJcx6vFLwp62YXlM7AS08UwWmm6Xe2fF2U4NTNR6
         yWCN8c0YVtJppUPL8y0kNdYSUZWxyDGmUVO62g2QpS/LGoGARRQvUglC+HsGlGUGMhwc
         vU7U+/h/sdBMqf9qnvOJZgAyZG4UbtczbVZqVjH9+5fNZPucu2oixHr/L58JoCi2yWKs
         oXfVZ/E5LuJ8RQe1vEMGdxZxYzWcCkLdJ2Ibxe221SR/0BeVWY5havsoxjPxTbChZGaF
         VxCg==
X-Gm-Message-State: AAQBX9e/5PqfDVE/Nd4cyZlW7DxlbyHEUE6BVj6ig2moSiJOGF1iRZbS
        OdTTv2xg4aCF8d+Lkpqk65qWlcFG33hPYWG40hBg0A==
X-Google-Smtp-Source: AKy350YmTigjCqxhZkDAGpzerjdcdATqE+ADmqBh+6UhRaIk/5PrHU2bagAlHyJOYhGEyC507M2UPcumZq5K6LpXxZM=
X-Received: by 2002:a81:838b:0:b0:54f:df51:7422 with SMTP id
 t133-20020a81838b000000b0054fdf517422mr1144857ywf.34.1682066566900; Fri, 21
 Apr 2023 01:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-4-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-4-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:42:35 +0200
Message-ID: <CACRpkdbFagmmO4Ood2AY7oZ2_vBwJuL5W9RhMMjCdetcjpbCjg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: st_sensors: Add lsm303d support to the
 LSM9DS0 IMU driver
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> The lsm303d is basically the lsm9ds0 without the gyroscope
> (which the LSM9DS0 IMU driver doesn't handle), as far as I
> can tell.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
