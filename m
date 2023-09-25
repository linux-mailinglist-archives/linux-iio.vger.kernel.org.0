Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B57ADC64
	for <lists+linux-iio@lfdr.de>; Mon, 25 Sep 2023 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjIYPyh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Sep 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjIYPyg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2023 11:54:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4FFC
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 08:54:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a65f9147ccso827455466b.1
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695657267; x=1696262067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHJtu6podpfARapK3BPhPtM/BxasDmazGp1qQa6N3I4=;
        b=1/1Jqhrz79d1vePwPDjNw+Wj1HsF5CZhNRIS+Ijd0lNrammrScep8HT6+qDGGajRgD
         N/K0CWEe2QCV+oe9szrarYaewMqhaktnRmkUMwtwg5q0kH7rf5KOaq93Lb5vsQH2QGKF
         PTUCPWDZQJeJ7vf6Lmg65p+QMeRF1YLNf3lEYooU4fMhQHTCdX0kjKWBcVRfNRMkHxOq
         oZk9GhwyLldIpPhU2/JZImKw6gzURaBpYbPiWuEkeRvZzZ5kSaAhY/oo33K/8u+qhoEc
         dLnqn8JC9WYKivveilVmNcQvm9v0HJq0XhbtogaffI68jLuASbNsyicHRD/8gfeY/g3I
         8t1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657267; x=1696262067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHJtu6podpfARapK3BPhPtM/BxasDmazGp1qQa6N3I4=;
        b=LnPvK4O5uU8XA41GfeHB7MJZxQN7UGpfenqt4XmRGOcJXTSqy6zk3scdOo72DTm5LT
         4UMTS7PZMSrsyr98Y226TdsAnMVtg1ClfvDDUn7mnHFqhtZD3LQul7cc1m4X45Ylp6kH
         Lt6U1h7TKsyvZwXOWe7uM9aoE9zDmHm+d6OXAdPvaI7hgjGwM5fuWOq0CDbFoAjQMe0z
         SdrWN5t2j4lVv+7wBhdd+t95NNQa1g9qI1RZWIWxrex86TW49r7zAEmSshch3mJlASMG
         I+Qbh3zkqA3Iawke4QyPhVyQlOnQLbMH0XOFWBi/zwvUp5WsaCl6PSjVhr0dvLae50J1
         d54g==
X-Gm-Message-State: AOJu0YzDNvYov/t73wiBOrZM4GxlhhJyaBxtjG3eg59XANIvzOYl17t1
        XIn2MzX4EP9NMCAE3UVv42S22XaRzp5qU2Qr7Hd8LA==
X-Google-Smtp-Source: AGHT+IFK6F50zQGV+rPZvvFCcUISHHonlUWkooK9m2LrV9WmWEzFMFKZSZUY4LT7DPrua2UQFWGYkh/M8Iiqyyf0n58=
X-Received: by 2002:a17:906:74c5:b0:9b2:7148:dd59 with SMTP id
 z5-20020a17090674c500b009b27148dd59mr5590808ejl.37.1695657267020; Mon, 25 Sep
 2023 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230921144400.62380-1-dlechner@baylibre.com> <20230921144400.62380-2-dlechner@baylibre.com>
 <20230924175720.3be2540b@jic23-huawei>
In-Reply-To: <20230924175720.3be2540b@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 25 Sep 2023 10:54:15 -0500
Message-ID: <CAMknhBFRe-M9VxHSBA9A7Royneg4zshrf42_2HtYZWRKQ4CCYw@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: iio: resolver: add devicetree
 bindings for ad2s1210
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        Apelete Seketeli <aseketeli@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 24, 2023 at 11:57=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Thu, 21 Sep 2023 09:43:42 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
...
> > +  fault-gpios:
> > +    description:
> > +      GPIO lines connected to the LOT and DOS pins. These pins combine=
d indicate
> > +      the type of fault present, if any. As these pins a pulled low to=
 indicate
> > +      a fault condition, they should be configured as GPIO_ACTIVE_LOW.
>
> What if someone is being odd and connected only 1 of them?
> It's annoying how often people run out of pins and do things like this.
>
> > +    minItems: 2
> > +    maxItems: 2
> > +
In this case the two lines are not independent. If both lines are
asserted, it does
not mean that both LOT and DOS faults exists but rather it means that a LOS
fault exists. So it would seem problematic to allow one without the other h=
ere.
