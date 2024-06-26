Return-Path: <linux-iio+bounces-6960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61104918502
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918B41C227F1
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13340186294;
	Wed, 26 Jun 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOKyDQFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6E1836F9;
	Wed, 26 Jun 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413835; cv=none; b=uQnqERzVbNzlri3dEf17o2/EJwn0eEYFNjeRuSgaK9RIoPcPDLOvkTUuWzW0wZ98O5OaT4skZS/oEKaTOx0dONWq5KcZSaHooHcaRE0U7DeCXoO6g794Y0lTilJFQ9PBHn38JM9NjaPDW8TzupZnszmSjC1La+Y5O78TP/4wmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413835; c=relaxed/simple;
	bh=aylTsZNMbWpcgr2C9z4hT6uerJ9r7O+M3Hr7j0fjrpU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQksjRLXlXS0BB+a4VF9/qiUAEHvDCEkyL9UW+oSsOXUDMfBcL3XDqFD+6+AdPdk6uyEr2DRF060qSpG4tnIJugKhegQjjkhSvqSCib+b3eqcsa/+WpKxTAvsEWwOn5FtK0LtbjIcf/8sL69Z2/AMpv6ZUzMyhsN7fG+/qv1gBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOKyDQFK; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e72224c395so78913411fa.3;
        Wed, 26 Jun 2024 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719413832; x=1720018632; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ydOd17bvYefKehT69ip6U/HmlDGpDikBgTd9pAZKo4E=;
        b=LOKyDQFKCB6y2JPyyWoH9zu9iPogr60vWtm/UD3nlAZlGg6ExgDo/bL6lKTe+Qih+k
         SBXPwEM0M9HUBHO/QX/ez1ceMMsz9xGln+Ba6NfHhU3eXJHAxBUu9n2+H5RWthkfL8GB
         PFlgjG5S5Kk7ha8FRkGv1iBujalOpxVTqaWYfi+sVU7CK1VhxWD9MVsSFft2OlDkTKun
         gJ2v+3JMmp+jlfMyTr2BlTDgCUNqszzwniAxRJjDIRfnLXsJBiu7kBIa0h2Ew1scUJAY
         ADpQhGVRZo+VqscLPtx4E7+EEQGlue0mote3lovb61HXao+0IO3b2uU/9D5wmQt9/ZxW
         Twng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413832; x=1720018632;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ydOd17bvYefKehT69ip6U/HmlDGpDikBgTd9pAZKo4E=;
        b=BGjn5qE5E8k7i6g5v2iNsgfs4OQjM6LeylrovRDRo2P8FKAmeNvZQxHQQ1aodLEIHJ
         +5qVZInOhM1wwVQDP9+IoL7Nu3XVCUAEyKXTE3QH/D64Wu5SfbXCuAyYjFJSWBjmrRND
         GW8I2JQLcRubhm7r1rutWHjNv2pSIPImrWmMnpg+EwDGH+F491AaTykEBoc9HLco+WAD
         G+mArLfePIEPqaPaC1j5YP1kgXS/qpD7G3XcK8mDOhD80MBQET93neGfZHZpQ9rcOeNQ
         AUVyp0xcO902/2oFwJQtokkfzhtcA2GvxlGaNINRC+TxciEj18laGZpcAMc2If2b7m7u
         j5jA==
X-Forwarded-Encrypted: i=1; AJvYcCVV8kkVt8HpvndrkU/DVcu7Wp9MFszJmVnKMNwI4HWV75OjABNCWboyRguNeIDeXKcnCp+eYuF2nbtnk9heIFDwjZ8MBmJXKXeDcH98DLjiTAY4Y5c/uJJ9aXgPA6XnmbYVA5K9gUOe
X-Gm-Message-State: AOJu0YxCluLJLajn/p1fEZddJOzzKTH7DfXUgHxZ4hCcdOvZ28tcsceR
	CrAd3GjbOtLaQSWnNDAvkUvMVReh5FepgcA5t+dpql9wEq+jPNFr
X-Google-Smtp-Source: AGHT+IEm++fIcw9IQr/yG3KQXi8MHlRpqhYq5O+Au0Yu98pN+96YTGslOz4JTDtcW2Kb5ozLE84yTA==
X-Received: by 2002:a2e:b173:0:b0:2ec:5abf:f3a8 with SMTP id 38308e7fff4ca-2ee4645fed3mr5715081fa.8.1719413832071;
        Wed, 26 Jun 2024 07:57:12 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303d7ddcsm7281734a12.17.2024.06.26.07.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:57:11 -0700 (PDT)
Message-ID: <0bebcdd4f1eb94c6fc34b18846ee12cc3c23be0d.camel@gmail.com>
Subject: Re: [PATCH v3 1/4] dev_printk: add new dev_err_probe() helpers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andi Shyti
 <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Andrzej
 Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>
Date: Wed, 26 Jun 2024 17:01:03 +0200
In-Reply-To: <20240617204153.7e36b157@jic23-huawei>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
	 <20240606-dev-add_dev_errp_probe-v3-1-51bb229edd79@analog.com>
	 <20240608190748.2577b8a5@jic23-huawei>
	 <20240617204153.7e36b157@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 20:41 +0100, Jonathan Cameron wrote:
> On Sat, 8 Jun 2024 19:07:48 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Thu, 6 Jun 2024 09:22:37 +0200
> > Nuno Sa <nuno.sa@analog.com> wrote:
> >=20
> > > This is similar to dev_err_probe() but for cases where an ERR_PTR() o=
r
> > > ERR_CAST() is to be returned simplifying patterns like:
> > >=20
> > > 	dev_err_probe(dev, ret, ...);
> > > 	return ERR_PTR(ret)
> > > or
> > > 	dev_err_probe(dev, PTR_ERR(ptr), ...);
> > > 	return ERR_CAST(ptr)
> > >=20
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>=C2=A0=20
> >=20
> > I'm convinced this is worth doing but would like inputs from others
> > before I pick this series up.
>=20
> Andi and Andy,
>=20
> You both commented on earlier versions.=C2=A0 Do you think this is a good
> change set?
>=20
> I've +CC a few more based on a quick look at the original
> dev_err_probe() series. Whilst this isn't adding a bunch of new stuff
> around deferred probing (like that series did), maybe some of those
> reviewers will give opinions here?
>=20

Hi,

I there something else needed from my side? Would be nice to have some
feedback...

- Nuno S=C3=A1



