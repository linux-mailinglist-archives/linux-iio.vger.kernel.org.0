Return-Path: <linux-iio+bounces-16449-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B03A53F31
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 01:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA23A7B25
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 00:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E21CD2C;
	Thu,  6 Mar 2025 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atx8Y3TD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A002110E;
	Thu,  6 Mar 2025 00:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741221164; cv=none; b=RA9iIQ/0UZuze0EY9WIqlbxNzqLOedovkR9QAdB2zdVmx3jLtmuZfhlH8oJ2WGoFvE7mA3dfC6uptHGUsxL2XovMAm1ZoP4XpE/hf4v9XwgXSNXvcklEUnGu+tyiXdZfq/NGV2IFInyZVWBFZnKfJk3VVyMG47sTbdlKNXYp4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741221164; c=relaxed/simple;
	bh=f5/msq66A8dGExPJS5orgs8AKsYIe/Lcr2NDLfzR7A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGXBDC2UF6ywIArkuSRvt7GWV1/cUBpLPp2hwwG+6zVKn50wD8pNuLl+amKxlZO0fy2uSRQjXMEk4eufG/U1+easmHjymHq9gWAjJVrQ2B4ZnkIPWS6sL40rFIUPvQnGS7FzbSENrntkKeyTOdySLQ4Vu0qyHwdw0Kgf5dk0E1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atx8Y3TD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e89959f631so1125716d6.3;
        Wed, 05 Mar 2025 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741221161; x=1741825961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbniOkrcE/iLVnL8rQsYyL/qvVYTkKklM91CTqrRJBI=;
        b=atx8Y3TDUXfX+GUHGeR84a2qbpKy/tWs7g+itfzhfjLqwdcJaA24vNwAbhNynSoLN6
         KWL525s90CT+TsPKU6Zx0U1K7UkPqvS1LJh2ZNh3/GvXdbilO/jiLU+RLKFgCSXnOUur
         uWAdQz3I0nVa2V92Jq5Y4EZ3XD2bpNeAAZ2aQPdG44qU2PO1mrMs4BWQ1Xd92UlZeFVp
         2GqYrs2h0N0ZACD03usjyzU4wfYnDuxOavhE8/o31UJMeh/dgOG9NMe1ja9oYbD3Z5n5
         +D+Ynx0zf6JPt1hwjMYgAC36FIzMk0PAZyZBxjDAIlbg7Xl5GOAkakM9U/2WAR1PWFZp
         QfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741221161; x=1741825961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbniOkrcE/iLVnL8rQsYyL/qvVYTkKklM91CTqrRJBI=;
        b=kxt0pi6XxGsrYs3Tw1W7xURswgyijh4e9vMyl7Pd7ZgNfEa19cB3yLGFwuPeRQDPcP
         O64Te/8AGVJ+uOqDgTnYquD2uB6+fFv+AdM6JV7napTxVcsK8/Bt8yn5BSnHwerdMwTM
         0yyZCOeq2O1clh0gnOAJIKdHqOUEnOZDJb+WtZhqXxzKThZ7Kh5xqTAnYkGjmCWmjo5k
         tPKLuXKcE0ofTj3d4RL49G97zgZLzE0s5B2C7cIbOHMTW5DYETU2CCYeouipOVnhnidO
         CjsupwGWfcI7OOVBvjchybg3pntd8ex5i/L77aO+EPhWyfZ8/KQldOH9d2a3jwk5zzbw
         kFRw==
X-Forwarded-Encrypted: i=1; AJvYcCU7YP+AUbE0+FdnuW2sgC7ZvPAwMKuhCqkfsVGkBEke2Hsb2TVy+Ke+dghvwJZLwBq17nLLliH704ed@vger.kernel.org, AJvYcCUq+kfxZIyJV4a6n1maCE/ZqRC/2EFJ1r0trWhUFRgyQfVVkj2XeLR4e88Wg3/TbAmPvn5bAEaXbe2H@vger.kernel.org, AJvYcCVa/VKd1TrwEw2zCPjKvGGln0QJLVrpcuP5L+CXh+5Rs/thwuwuwmTd4JBB20SXuzvFHUhwztROwUiKjior@vger.kernel.org
X-Gm-Message-State: AOJu0YzVY4tXK8oV8TGOzy4DSxWtw/0lHQcLKIlTJMUz1N9ZS5HdHRII
	8IkSohoC6emnBRvJChFwTFMj8yi5b/O8V63OO8Ov5ug+UMeykmn4n5hePxLj4eJr/NoMZVjZwl/
	SaCzFRElWWSnX1CXo2NVFN/i6hbI=
X-Gm-Gg: ASbGncsPU0WCjPET+W/VFHt1d6oycFIlUTyBCOEfn9WV1fSNp8I3I4k5iO8l0DZ0YLX
	SS/TPF5ouPsGkQqZypbsIrAIOTOTA0NERaG6rXjqdRzojHLLJWk9Zv6aTP1ZFs02Iw5yPbQCihY
	zitIYe+pDDVfGZx3rg7Z0tsBe3Ig==
X-Google-Smtp-Source: AGHT+IG+AhTOU/hFmUj2Gkpld0BqtJ/4yuByg5APV8R/JeUdRUJkWdIIvsJDj978xbhdoWG645LFlNqS3HrGShS/6Y0=
X-Received: by 2002:a05:6214:2b09:b0:6e6:6535:17dd with SMTP id
 6a1803df08f44-6e8e6d13ef2mr91605216d6.7.1741221160908; Wed, 05 Mar 2025
 16:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303235930.68731-1-danascape@gmail.com> <20250304143918.733d6cca@jic23-huawei>
In-Reply-To: <20250304143918.733d6cca@jic23-huawei>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 Mar 2025 13:32:28 +1300
X-Gm-Features: AQ5f1JosxNJs8S75DECePZKWETpL2y5LjB4cLtk5HNNr9lPQYzI9s5_-kDJ6Ibo
Message-ID: <CAGsJ_4zGOvEK-NE1DBtk5jQZCfPp0vtjOb2pWskmhAAn_y93eQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: accel: add binding documentation for ADIS16203
To: Jonathan Cameron <jic23@kernel.org>, Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 3:39=E2=80=AFAM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Tue,  4 Mar 2025 05:29:30 +0530
> Saalim Quadri <danascape@gmail.com> wrote:
>
> > This patch add device tree binding documentation for ADIS16203.
> >
> > Signed-off-by: Saalim Quadri <danascape@gmail.com>
> > ---
> > Changes:
> > V1 - V2: change compatible property from enum to const
> >
> >  .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adi=
s16203.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.=
yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> > new file mode 100644
> > index 000000000000..64370f13e1dc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADIS16203 Programmable 360 Degrees Inclinometer
> > +
> > +maintainers:
> > +  - Barry Song <21cnbao@gmail.com>
> I think you'll be dropping this patch anyway, but just a quick not that
> it isn't good to volunteer people.  Barry hasn't worked on these
> devices for quite a long time now so seems unlikely he agreed to this.

Hi Saalim, if you're sending a v2, feel free to nominate yourself or anyone
interested as the maintainer. Apologies, but I probably won=E2=80=99t have =
time to
handle this :-)

>
> Jonathan

Thanks
Barry

