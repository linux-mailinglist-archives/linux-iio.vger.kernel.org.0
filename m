Return-Path: <linux-iio+bounces-737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7808090FE
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467571C208B2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A54EB42;
	Thu,  7 Dec 2023 19:06:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0910DC;
	Thu,  7 Dec 2023 11:06:04 -0800 (PST)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C679B401F9;
	Thu,  7 Dec 2023 18:56:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 3B73B1A;
	Thu,  7 Dec 2023 18:56:18 +0000 (UTC)
Message-ID: <c2138d24bcaec664e9239e6e1bade6116db04027.camel@perches.com>
Subject: Re: [PATCH v3 01/13] scripts: checkpatch: Add __aligned to the list
 of attribute notes
From: Joe Perches <joe@perches.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com, 
 dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
  Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  dan.carpenter@linaro.org, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 07 Dec 2023 10:56:17 -0800
In-Reply-To: <e8d5343a0a6b5d976873d3896ad9ab0c88505c6d.1701971344.git.marcelo.schmitt1@gmail.com>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
	 <e8d5343a0a6b5d976873d3896ad9ab0c88505c6d.1701971344.git.marcelo.schmitt1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3B73B1A
X-Rspamd-Server: rspamout02
X-Stat-Signature: uc1ruosambyhhk1jej9gqi9e1oaeh155
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX188AVrchA8Q6aSf2ubwLQwytSUKZZesA8Q=
X-HE-Tag: 1701975378-987312
X-HE-Meta: U2FsdGVkX1+CjSoSgA4ZE8tPllT47ZdAoJmXNslwU/RdfB9ysc18qu5HDv/6UxcleLmTGK/xkn9Crk4a0B67WkHfmt5oOKGXXZandu+E/HzSP+oWthr6rm6yzoYJmAA7i5VALJXVA3n4Y36OKkM62KcwWVxY4XGB6CeA9rYvioQ1Gl6DVSBzE8NuJGpwpv74aCXVlhLG0WnOdaU5RE8Kqwz2ja6pUMPtmiGEB2xR6/EOLrBPmq/zTGR5nqcJh6DYGk1/Iv7YN85Ep1EuFNhKNfPeZ9kZgiEqWOP/3OC7YR5LfPStgN5p1Rpq+gvkEg+5CbJINLb08STI2YpAOkWEv7WNHylca8Hiyg3x4z2SgBS+tvm0qIoZgggs5kBujoLD

On Thu, 2023-12-07 at 15:37 -0300, Marcelo Schmitt wrote:
> Checkpatch presumes attributes marked with __aligned(alignment) are part
> of a function declaration and throws a warning stating that those
> compiler attributes should have an identifier name which is not correct.
> Add __aligned compiler attributes to the list of attribute notes
> so they don't cause warnings anymore.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> The patch that would trigger the mentioned checkpatch warning in this ser=
ies is
> patch number 12 (iio: adc: Add support for AD7091R-8).
>=20
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..e6773ae0ad08 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -512,6 +512,7 @@ our $Attribute	=3D qr{
>  			__ro_after_init|
>  			__kprobes|
>  			$InitAttribute|
> +			__aligned|

__aligned takes an argument so I think there needs
to have something like the use of __alloc_size below
this addition
	__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\)

maybe

			__aligned\s*\([^\)]*\)

though even that would work well with most uses it
would not work with things like

drivers/crypto/inside-secure/safexcel_hash.c:   u8 cache[HASH_CACHE_SIZE] _=
_aligned(sizeof(u32));


