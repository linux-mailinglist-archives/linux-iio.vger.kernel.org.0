Return-Path: <linux-iio+bounces-13810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DDB9FCD4D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD7B1882FA1
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395214831C;
	Thu, 26 Dec 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvv895u0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC561EEE0;
	Thu, 26 Dec 2024 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735240498; cv=none; b=nOL+Fam9F+w4xu1PpbjOJNgbteM86lxYcgmAVfppKH+/krzwV2Q1ATmxrFYE6OGsZLkE9u9Q0LWN5cseUdPeEhQfPeGZZGiPiYFWwgbiFfgtvbhEcJv/0lpqWHnVetkdM4mvQcPoLGChp2Guk9/EP3MFQgJSgoxtDXS5NlXPyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735240498; c=relaxed/simple;
	bh=8mxN23azHh6+Uax9ZTY/CvRBGB3REprREa5S/7fntYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xng8MFkDPRzLC1MkQJ9n8Hmb7v2Tp20idILoJCNqbgFKaZK30t6hhYGHumdZRAFxm0pNZi1DpU5ncc8eD3MDCYFI6JwpwhxT66sSG69AEPHYVLYbcbRTU8GCbzHfKMANx8xhw5ZBjnycOrwzOK8rgpezNc3JMzTWdviHv6DF830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lvv895u0; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b9bc648736so479363985a.1;
        Thu, 26 Dec 2024 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735240496; x=1735845296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrW2Ryx54/+kyYVENZ45xZ85tdktdL0VXxj6y4KcRe0=;
        b=Lvv895u0ugUfClF6nJ5abA2Kc3CwMTtGJvvd/uUl5Q/b1I3O1Hk4ciod7oEwSMkE6i
         WS4Xx21XBLwn0oh8OeVvhToeYNsYNW7++L9Ds77vvBwQGjxYqK0kW0G5/TuByLHjALtf
         Ahu3VRgTM7ww6CUhjqpkLH5EUz9oGiObA00fWIBlWMAVaGJ6jsUaUYObu5LpWEJnuoRr
         7XLz+hkKKDSPhZa6hE2gFdSNwbBIYABZgx9iv4zWclnJ6zHZEM5loU4Sdcpx5ZxmDPC7
         Yk7r8NZqhlssfkLVSh5aE3mofMyBXAj27RRFRJ5ZiFrx2WZrFK1ZmdKVYYHRxbb6nMd0
         8m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735240496; x=1735845296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrW2Ryx54/+kyYVENZ45xZ85tdktdL0VXxj6y4KcRe0=;
        b=uDVuaAzObh6QutWkYMr3a3ee4Xpudz85ajcg4x8J3cdozYm/EC0WVFmKuSb2A9fauk
         bDiEb7ckkgGM2jsST7Pf+rzxoKAu5FvvwL7WJHkQPnwmdv3IoyJxnE59Jk/KA9Js543i
         rgKwZwgLWhVv6cxqSJtrCKaY13a4+N+yTLW/ahNFca6bz2zXR3vKsEQhg7e7EAzVxgDq
         ZJp0Q9aH69bMcy7z1iK2vrTiiKf0+Kwxk2cfGlq+J248HkjoKsm2wKh8AKnfzpjoKaXP
         X3wAqBiKE5zI1Wq7TkSf4Ek3L7+ULBq0SK5azfJRfnyNKdaKpyUFRL8OQaIR0t5/mYy5
         X4EA==
X-Forwarded-Encrypted: i=1; AJvYcCULdu33wBWcWwTKJYRO/cf+eqqQTGVs2CJS41Rwk0LOujTEhptDdBPJ3rcCk4zZwo6o+jpVx2UB8iWd@vger.kernel.org, AJvYcCWEqWkLihJcDpfnKtNNBQTCiObdhts/INPW8KCz4PQcQwNmHlvrJj5jsT05T5v3K+kWTre7lgbufDVx@vger.kernel.org, AJvYcCXMXXEBrS8PvO72cQAQJSlBHmoV+T0nMCfDv9/Mg+K5go0DfMUectl5YgCT5ZK5SbpDXdU6Zp0B3JFi+Mf4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj25yx4KkgbVzHnCtOHiBvSh63qe4U5paMwBDayupoiYxJvRe5
	InDqeYF8X71r7EPEA1938ZyFb8ot4Eut608MbFyO42NHnSKUJdFw
X-Gm-Gg: ASbGncsMezeyqMKmXpZpUvP1MjqYkC4ih3Wjh1AYtXA0eRfDcrs69mnKsafxwJclFPs
	kyS9y6vC6Ec0duFv+LoZK9BqbNKv5MaFlKEnnQvGYyj4gNBgaIttRmbix1Dkyy9+cOLyealFa0S
	onKkH7jAOFDraerjS/+WHTGASMLmnhc2DqfliYcS5pSBzmpsSNhsY2TozI+W+ubhvg6yKmn48E3
	Pbw0ZeEGnqh0vpLrrA+WbF+0hfHAXAVMR18NcTI+9Tre632d34xzk4+V2U=
X-Google-Smtp-Source: AGHT+IHPmZyxXVnDsRgBXkkGnzS9A97s9dC8nlCGIE7/0TNePzAYF5A11nSqSxU/6xDM4Ory+aBE8g==
X-Received: by 2002:a05:620a:4708:b0:7b6:c6f8:1d2a with SMTP id af79cd13be357-7b9ba7a56fbmr3115805885a.28.1735240496255;
        Thu, 26 Dec 2024 11:14:56 -0800 (PST)
Received: from VM-Arch ([2603:7000:d100:26f7:906d:da54:c718:2403])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4cc3ffsm639242085a.109.2024.12.26.11.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 11:14:55 -0800 (PST)
Date: Thu, 26 Dec 2024 14:06:50 -0500
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jagathjog1996@gmail.com, trabarni@gmail.com, danila@jiaxyga.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: iio: imu: bmi270: add boolean type
 for drive-open-drain
Message-ID: <qnxoxgps35duycdvk6f5kguizgup6d4tzwb3ax6avqwenexvun@sbm2cwzugry4>
References: <20241219234745.58723-1-vassilisamir@gmail.com>
 <20241219234745.58723-3-vassilisamir@gmail.com>
 <uqn4jpowzqhchthn3i2fpg7j52c7y67gawg5ausrt5j3cemq52@c3l54jktq2wv>
 <20241225-spew-cosmos-12da85771c8c@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241225-spew-cosmos-12da85771c8c@spud>

On Wed, Dec 25, 2024 at 02:21:42PM +0000, Conor Dooley wrote:
> On Mon, Dec 23, 2024 at 02:50:53PM -0500, Alex Lanzano wrote:
> > On Fri, Dec 20, 2024 at 12:47:44AM +0100, Vasileios Amoiridis wrote:
> > > Add missing type description "boolean" for the drive-open-drain property.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > > index 7b0cde1c9b0a..860a6c1fea3c 100644
> > > --- a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> > > @@ -41,6 +41,7 @@ properties:
> > >          - INT2
> > >  
> > >    drive-open-drain:
> > > +    type: boolean
> > >      description:
> > >        set if the specified interrupt pins should be configured as
> > >        open drain. If not set, defaults to push-pull.
> > 
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> 
> What do you mean with this tag? A sign-off means you're part of the
> chain of custody of the patch, but you're neither author nor submitter.
> Did you mean Reviewed-by or Acked-by?

Whoops! I ment to use the reviewed-by tag


